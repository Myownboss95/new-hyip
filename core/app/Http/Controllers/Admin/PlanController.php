<?php

namespace App\Http\Controllers\Admin;

use App\Lib\HyipLab;
use App\Models\Plan;
use App\Models\Invest;
use App\Models\TimeSetting;
use App\Models\Transaction;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Validation\ValidationException;

class PlanController extends Controller
{
    public function index()
    {
        $pageTitle = "Plans";
        $plans     = Plan::with('timeSetting')->orderBy('id', 'desc')->get();
        $times     = TimeSetting::where('status', 1)->get();
        return view('admin.plan.index', compact('pageTitle', 'plans', 'times'));
    }

    public function store(Request $request)
    {
        $this->validation($request);
        $plan = new Plan();
        $this->saveData($plan, $request);

        $notify[] = ['success', 'Plan added successfully'];
        return back()->withNotify($notify);
    }

    public function update(Request $request, $id)
    {
        $this->validation($request);
        $plan = Plan::findOrFail($id);
        $this->saveData($plan, $request);

        $notify[] = ['success', 'Plan updated successfully'];
        return back()->withNotify($notify);
    }

    protected function saveData($plan, $request)
    {
        $plan->name              = $request->name;
        $plan->minimum           = $request->minimum ?? 0;
        $plan->maximum           = $request->maximum ?? 0;
        $plan->fixed_amount      = $request->amount ?? 0;
        $plan->interest          = $request->interest;
        $plan->interest_type     = $request->interest_type == 1 ? 1 : 0;
        $plan->time_setting_id   = $request->time;
        $plan->capital_back      = $request->capital_back ?? 0;
        $plan->lifetime          = $request->return_type == 1 ? 1 : 0;
        $plan->repeat_time       = $request->repeat_time ?? 0;
        $plan->compound_interest = $request->compound_interest ? 1 : 0;
        $plan->hold_capital      = $request->hold_capital ? 1 : 0;
        $plan->featured          = $request->featured ? 1 : 0;
        $plan->save();
    }

    protected function validation($request)
    {
        $request->validate([
            'name'          => 'required',
            'invest_type'   => 'required|in:1,2',
            'interest_type' => 'required|in:1,2',
            'interest'      => 'required|numeric|gt:0',
            'time'          => 'required|integer|gt:0',
            'return_type'   => 'required|integer|in:1,0',
            'minimum'       => 'nullable|required_if:invest_type,1|gt:0',
            'maximum'       => 'nullable|required_if:invest_type,1|gt:minimum',
            'amount'        => 'nullable|required_if:invest_type,2|gt:0',
            'repeat_time'   => 'nullable|required_if:return_type,2|integer|gt:0',
            'capital_back'  => 'nullable|required_if:return_type,2|in:1,0',
        ]);

        if ($request->compound_interest && ((!$request->capital_back && !$request->return_type) || $request->interest_type == 2)) {
            throw ValidationException::withMessages(['error' => 'For compound interest, a lifetime plan or capital return and a percentage-based interest rate are required.']);
        }

        if ($request->hold_capital && !$request->capital_back) {
            throw ValidationException::withMessages(['error' => 'When hold capital is enabled, capital back is required.']);
        }

    }

    public function status($id)
    {
        return Plan::changeStatus($id);
    }

    public function cancelInvest(Request $request)
    {
        $request->validate([
            'invest_id' => 'required|integer',
            'action'    => 'required|in:1,2,3,4',
        ]);

        $invest = Invest::with('user')->where('status', 1)->findOrFail($request->invest_id);

        if ($request->action == 1 || $request->action == 2) {
            HyipLab::capitalReturn($invest, $invest->wallet_type);
        }

        if($request->action == 2 || $request->action == 4){
            $this->interestBack($invest);
        }

        $invest->status = 2;
        $invest->save();

        $notify[]=['success','Investment canceled successfully'];
        return back()->withNotify($notify);
    }


    private function interestBack($invest)
    {
        $user = $invest->user;
        $totalPaid = $invest->paid;

        if($totalPaid <= $user->interest_wallet){
            $user->interest_wallet -= $totalPaid;
            $this->createTransaction($user->id, $totalPaid, $user->interest_wallet, 'interest_wallet');
        }elseif($totalPaid <= $user->interest_wallet + $user->deposit_wallet){
            $user->deposit_wallet -= ($totalPaid - $user->interest_wallet);
            $this->createTransaction($user->id, $totalPaid - $user->interest_wallet, $user->deposit_wallet, 'deposit_wallet');
            $this->createTransaction($user->id, $user->interest_wallet, 0, 'interest_wallet');
            $user->interest_wallet = 0;
        }else{
            $user->interest_wallet -= ($totalPaid - $user->deposit_wallet);
            $this->createTransaction($user->id, $totalPaid - $user->deposit_wallet, $user->interest_wallet, 'interest_wallet');
            $this->createTransaction($user->id, $user->deposit_wallet, 0, 'deposit_wallet');
            $user->deposit_wallet = 0;
        }

    }

    private function createTransaction($userId, $amount, $postBalance, $wallet)
    {
        $transaction               = new Transaction();
        $transaction->user_id      = $userId;
        $transaction->amount       = $amount;
        $transaction->post_balance = $postBalance;
        $transaction->charge       = 0;
        $transaction->trx_type     = '-';
        $transaction->details      = 'Interest return for investment canceled';
        $transaction->trx          = getTrx();
        $transaction->wallet_type  = $wallet;
        $transaction->remark       = 'interest_return';
        $transaction->save();
    }


}
