<?php

namespace App\Http\Controllers\Gateway\BTCPay;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Gateway\PaymentController;
use App\Models\AdminNotification;
use App\Models\Deposit;
use App\Models\Gateway;
use BTCPayServer\Client\Invoice;
use BTCPayServer\Client\Webhook;
use BTCPayServer\Util\PreciseNumber;

class ProcessController extends Controller
{
    public static function process($deposit)
    {
        $btcPay = json_decode($deposit->gatewayCurrency()->gateway_parameter);

        $client = new Invoice($btcPay->server_name, $btcPay->api_key);

        try {
            $amount  = PreciseNumber::parseFloat($deposit->final_amo);
            $invoice = $client->createInvoice(
                $btcPay->store_id,
                gs('cur_text'),
                $amount,
                $deposit->trx
            );
            $deposit->btc_wallet = $invoice->getData()['id'];
            $deposit->detail = json_encode($invoice->getData());
            $deposit->save();

            $send['redirect']     = true;
            $send['redirect_url'] = $invoice['checkoutLink'];



        } catch (\Throwable$e) {
            $send['error']     = true;
            $send['message'] = $e->getMessage();;
        }

        return json_encode($send);
    }

    public function ipn()
    {
        $rawPostData = file_get_contents("php://input");
        if ($rawPostData) {
            $headers = getallheaders();
            foreach ($headers as $key => $value) {
                if (strtolower($key) === 'btcpay-sig') {
                    $signature = $value;
                }
            }

            $gateway = Gateway::where('alias', 'BTCPay')->first();
            $gatewayParameters = json_decode($gateway->gateway_parameters);

            if (!isset($signature) || !$this->validWebhookRequest($signature, $rawPostData, $gatewayParameters->secret_code->value)) {
                $adminNotification            = new AdminNotification();
                $adminNotification->user_id   = 0;
                $adminNotification->title     = 'Webhook request validation failed.';
                $adminNotification->click_url = '#';
                $adminNotification->save();
                return false;
            }


            try {
                $postData = json_decode($rawPostData, false, 512, JSON_THROW_ON_ERROR);

                if (!isset($postData->invoiceId)) {
                    $adminNotification            = new AdminNotification();
                    $adminNotification->user_id   = 0;
                    $adminNotification->title     = 'No BTCPay invoiceId provided, aborting.';
                    $adminNotification->click_url = '#';
                    $adminNotification->save();
                    return false;
                }

                $deposit = Deposit::where('btc_wallet', $postData->invoiceId)->where('status', 0)->first();
                if ($deposit) {
                    $this->processPayment($deposit, $postData);
                }

            } catch (\Throwable$e) {
                $adminNotification            = new AdminNotification();
                $adminNotification->user_id   = 0;
                $adminNotification->title     = 'Error decoding webhook payload: ' . $e->getMessage();
                $adminNotification->click_url = '#';
                $adminNotification->save();
                return false;
            }
        }

    }

    public function processPayment($deposit, $webhookData)
    {
        if ($webhookData->type == 'InvoicePaymentSettled') {
            if ($webhookData->afterExpiration) {
                $adminNotification            = new AdminNotification();
                $adminNotification->user_id   = 0;
                $adminNotification->title     = 'Payment expired for trx ' . $deposit->trx;
                $adminNotification->click_url = '#';
                $adminNotification->save();
                return false;
            } else {
                if ($webhookData->payment->status == 'Settled') {
                    PaymentController::userDataUpdate($deposit);
                    return true;
                } else {
                    $adminNotification            = new AdminNotification();
                    $adminNotification->user_id   = 0;
                    $adminNotification->title     = 'Amount is not fully paid for trx ' . $deposit->trx;
                    $adminNotification->click_url = '#';
                    $adminNotification->save();
                    return false;
                }

            }
        }
    }

    private function validWebhookRequest(string $signature, string $requestData, $secretCode): bool
    {
        return Webhook::isIncomingWebhookRequestValid($requestData, $signature, $secretCode);
    }

}