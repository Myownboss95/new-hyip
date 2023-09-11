<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Gateway\PaymentController;
use App\Lib\HyipLab;
use App\Models\GatewayCurrency;
use App\Models\Invest;
use App\Models\Plan;
use App\Models\Pool;
use App\Models\PoolInvest;
use App\Models\ScheduleInvest;
use App\Models\Staking;
use App\Models\StakingInvest;
use App\Models\Transaction;
use App\Models\UserRanking;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class InvestController extends Controller
{
    public function invest(Request $request)
    {
        $this->validation($request);

        $plan = Plan::with('timeSetting')->whereHas('timeSetting', function ($time) {
            $time->where('status', 1);
        })->where('status', 1)->findOrFail($request->plan_id);

        $this->planInfoValidation($plan, $request);

        $user = auth()->user();

        if ($request->invest_time == 'schedule' && gs('schedule_invest')) {
            $this->saveInvestSchedule($request);
            $notify[] = ['success', 'Invest scheduled successfully'];
            return back()->withNotify($notify);
        }

        $wallet = $request->wallet_type;

        //Direct checkout
        if ($wallet != 'deposit_wallet' && $wallet != 'interest_wallet') {

            $gate = GatewayCurrency::whereHas('method', function ($gate) {
                $gate->where('status', 1);
            })->find($request->wallet_type);

            if (!$gate) {
                $notify[] = ['error', 'Invalid gateway'];
                return back()->withNotify($notify);
            }

            if ($gate->min_amount > $request->amount || $gate->max_amount < $request->amount) {
                $notify[] = ['error', 'Please follow deposit limit'];
                return back()->withNotify($notify);
            }

            $data = PaymentController::insertDeposit($gate, $request->amount, $plan, $request->compound_interest);
            session()->put('Track', $data->trx);
            return to_route('user.deposit.confirm');
        }

        if ($request->amount > $user->$wallet) {
            $notify[] = ['error', 'Your balance is not sufficient'];
            return back()->withNotify($notify);
        }

        $hyip = new HyipLab($user, $plan);
        $hyip->invest($request->amount, $wallet, $request->compound_interest);

        $notify[] = ['success', 'Invested to plan successfully'];
        return back()->withNotify($notify);
    }

    private function validation($request)
    {
        $validationRule = [
            'amount'            => 'required|min:0',
            'plan_id'           => 'required',
            'wallet_type'       => 'required',
            'compound_interest' => 'nullable|numeric|min:0',
        ];

        $general = gs();

        if ($general->schedule_invest) {
            $validationRule['invest_time'] = 'required|in:invest_now,schedule';
        }

        if ($request->invest_time == 'schedule') {
            $validationRule['wallet_type']    = 'required|in:deposit_wallet,interest_wallet';
            $validationRule['schedule_times'] = 'required|integer|min:1';
            $validationRule['hours']          = 'required|integer|min:1';
        }

        $request->validate($validationRule, [
            'wallet_type.in'       => 'For schedule invest pay via must be deposit wallet or interest wallet',
            'wallet_type.required' => 'Pay via field is required',
        ]);
    }

    private function planInfoValidation($plan, $request)
    {
        if ($request->compound_interest) {
            if (!$plan->compound_interest) {
                throw ValidationException::withMessages(['error' => 'Compound interest optional is not available for this plan.']);
            }

            if ($plan->repeat_time && $plan->repeat_time <= $request->compound_interest) {
                throw ValidationException::withMessages(['error' => 'Compound interest times must be fewer than repeat times.']);
            }
        }

        if ($plan->fixed_amount > 0) {
            if ($request->amount != $plan->fixed_amount) {
                throw ValidationException::withMessages(['error' => 'Please check the investment limit']);
            }
        } else {
            if ($request->amount < $plan->minimum || $request->amount > $plan->maximum) {
                throw ValidationException::withMessages(['error' => 'Please check the investment limit']);
            }
        }
    }

    public function statistics()
    {
        $pageTitle  = 'Invest Statistics';
        $invests    = Invest::where('user_id', auth()->id())->orderBy('id', 'desc')->with('plan.timeSetting')->paginate(getPaginate(10));
        $activePlan = Invest::where('user_id', auth()->id())->where('status', 1)->count();

        $investChart = Invest::where('user_id', auth()->id())->with('plan')->groupBy('plan_id')->select('plan_id')->selectRaw("SUM(amount) as investAmount")->orderBy('investAmount', 'desc')->get();
        return view(activeTemplate() . 'user.invest_statistics', compact('pageTitle', 'invests', 'investChart', 'activePlan'));
    }

    public function log()
    {
        $pageTitle = 'Invest Logs';
        $invests   = Invest::where('user_id', auth()->id())->orderBy('id', 'desc')->with('plan.timeSetting')->paginate(getPaginate());
        return view(activeTemplate() . 'user.invests', compact('pageTitle', 'invests'));
    }

    public function details($id)
    {
        $pageTitle    = 'Investment Details';
        $invest       = Invest::with('plan', 'user')->where('user_id', auth()->id())->findOrFail(decrypt($id));
        $transactions = Transaction::where('invest_id', $invest->id)->orderBy('id', 'desc')->paginate(getPaginate());

        return view(activeTemplate() . 'user.invest_details', compact('pageTitle', 'invest', 'transactions'));
    }

    public function manageCapital(Request $request)
    {
        $request->validate([
            'invest_id' => 'required|integer',
            'capital'   => 'required|in:reinvest,capital_back',
        ]);

        $user   = auth()->user();
        $invest = Invest::with('user')->where('user_id', $user->id)->where('capital_status', 1)->where('capital_back', 0)->where('status', 0)->findOrFail($request->invest_id);

        if ($request->capital == 'capital_back') {
            HyipLab::capitalReturn($invest);
            $notify[] = ['success', 'Capital added to your wallet successfully'];
            return back()->withNotify($notify);
        }

        $plan = Plan::whereHas('timeSetting', function ($timeSetting) {
            $timeSetting->where('status', 1);
        })->where('status', 1)->find($invest->plan_id);

        if (!$plan) {
            $notify[] = ['error', 'This plan currently unavailable'];
            return back()->withNotify($notify);
        }

        HyipLab::capitalReturn($invest);
        $hyip = new HyipLab($user, $plan);
        $hyip->invest($invest->amount, 'interest_wallet', $invest->compound_times);

        $notify[] = ['success', 'Reinvested to plan successfully'];
        return back()->withNotify($notify);
    }

    public function ranking()
    {
        if (!gs()->user_ranking) {
            abort(404);
        }

        $pageTitle    = 'User Ranking';
        $userRankings = UserRanking::active()->get();
        $user         = auth()->user()->load('userRanking', 'referrals');

        return view(activeTemplate() . 'user.user_ranking', compact('pageTitle', 'userRankings', 'user'));
    }

    private function saveInvestSchedule($request)
    {
        $scheduleInvest                     = new ScheduleInvest();
        $scheduleInvest->user_id            = auth()->id();
        $scheduleInvest->plan_id            = $request->plan_id;
        $scheduleInvest->wallet             = $request->wallet_type;
        $scheduleInvest->amount             = $request->amount;
        $scheduleInvest->schedule_times     = $request->schedule_times;
        $scheduleInvest->rem_schedule_times = $request->schedule_times;
        $scheduleInvest->interval_hours     = $request->hours;
        $scheduleInvest->compound_times     = $request->compound_interest ?? 0;
        $scheduleInvest->next_invest        = now()->addHours($request->hours);
        $scheduleInvest->save();
    }

    public function scheduleInvests(Request $request)
    {
        if (!gs('schedule_invest')) {
            abort(404);
        }
        $pageTitle       = 'Schedule Invests';
        $scheduleInvests = ScheduleInvest::with('plan.timeSetting')->where('user_id', auth()->id())->orderBy('id', 'desc')->paginate(getPaginate());

        return view(activeTemplate() . 'user.schedule_invest', compact('pageTitle', 'scheduleInvests'));
    }

    public function scheduleInvestStatus($id)
    {
        if (!gs('schedule_invest')) {
            abort(404);
        }
        $scheduleInvest         = ScheduleInvest::where('user_id', auth()->id())->where('rem_schedule_times', '>', 0)->findOrFail($id);
        $scheduleInvest->status = !$scheduleInvest->status;
        $scheduleInvest->save();

        $notification = $scheduleInvest->status ? 'enabled' : 'disabled';
        $notify[]     = ['success', "Schedule invest $notification successfully"];

        return back()->withNotify($notify);
    }

    public function staking()
    {
        if (!gs('staking_option')) {
            abort(404);
        }
        $pageTitle  = 'My Staking';
        $stakings   = Staking::active()->paginate(getPaginate());
        $myStakings = StakingInvest::where('user_id', auth()->id())->orderBy('id', 'desc')->paginate(getPaginate());
        return view($this->activeTemplate . 'user.staking', compact('pageTitle', 'stakings', 'myStakings'));
    }

    public function saveStaking(Request $request)
    {
        if (!gs('staking_option')) {
            abort(404);
        }

        $min = getAmount(gs('staking_min_amount'));
        $max = getAmount(gs('staking_max_amount'));

        $request->validate([
            'duration' => 'required|integer|min:1',
            'amount'   => "required|numeric|between:$min,$max",
            'wallet'   => 'required|in:deposit_wallet,interest_wallet',
        ]);

        $user   = auth()->user();
        $wallet = $request->wallet;

        if ($user->$wallet < $request->amount) {
            $notify[] = ['error', 'Insufficient Balance'];
            return back()->withNotify($notify);
        }

        $staking  = Staking::active()->findOrFail($request->duration);
        $interest = $request->amount * $staking->interest_percent / 100;

        $stakingInvest                = new StakingInvest();
        $stakingInvest->user_id       = auth()->id();
        $stakingInvest->staking_id    = $staking->id;
        $stakingInvest->invest_amount = $request->amount;
        $stakingInvest->interest      = $interest;
        $stakingInvest->end_at        = now()->addDays($staking->days);
        $stakingInvest->save();

        $user->$wallet -= $request->amount;
        $user->save();

        $transaction               = new Transaction();
        $transaction->user_id      = $user->id;
        $transaction->amount       = $request->amount;
        $transaction->post_balance = $user->$wallet;
        $transaction->charge       = 0;
        $transaction->trx_type     = '-';
        $transaction->details      = 'Staking investment';
        $transaction->trx          = getTrx();
        $transaction->wallet_type  = $wallet;
        $transaction->remark       = 'staking_invest';
        $transaction->save();

        $notify[] = ['success', 'Staking investment added successfully'];
        return back()->withNotify($notify);
    }

    public function pool()
    {
        if(!gs('pool_option')){
            abort(404);
        }

        $pageTitle = "Pool Plan";
        $pools     = Pool::active()->where('share_interest', 0)->get();

        return view($this->activeTemplate . 'user.pool', compact('pageTitle', 'pools'));
    }

    public function poolInvests(Request $request)
    {
        if (!gs('pool_option')) {
            abort(404);
        }
        $pageTitle = 'My Pool Invests';
        $poolInvests = PoolInvest::with('pool')->where('user_id', auth()->id())->orderBy('id', 'desc')->paginate(getPaginate());
        return view($this->activeTemplate.'user.pool_invest', compact('pageTitle','poolInvests'));
    }

    public function poolInvest(Request $request)
    {
        if (!gs('pool_option')) {
            abort(404);
        }
        $request->validate([
            'pool_id'     => 'required|integer',
            'wallet_type' => 'required|in:deposit_wallet,interest_wallet',
            'amount'      => 'required|numeric|gt:0',
        ]);

        $pool   = Pool::active()->findOrFail($request->pool_id);
        $user   = auth()->user();
        $wallet = $request->wallet_type;

        if ($pool->start_date <= now()) {
            $notify[] = ['error', 'The investment period for this pool has ended.'];
            return back()->withNotify($notify);
        }

        if ($request->amount > $pool->amount - $pool->invested_amount) {
            $notify[] = ['error', 'Pool invest over limit!'];
            return back()->withNotify($notify);
        }

        if ($user->$wallet < $request->amount) {
            $notify[] = ['error', 'Insufficient balance!'];
            return back()->withNotify($notify);
        }

        $poolInvest = PoolInvest::where('user_id', $user->id)->where('pool_id', $pool->id)->where('status', 1)->first();

        if (!$poolInvest) {
            $poolInvest          = new PoolInvest();
            $poolInvest->user_id = $user->id;
            $poolInvest->pool_id = $pool->id;
        }

        $poolInvest->invest_amount += $request->amount;
        $poolInvest->save();

        $pool->invested_amount += $request->amount;
        $pool->save();

        $user->$wallet -= $request->amount;
        $user->save();

        $transaction               = new Transaction();
        $transaction->user_id      = $user->id;
        $transaction->amount       = $request->amount;
        $transaction->post_balance = $user->$wallet;
        $transaction->charge       = 0;
        $transaction->trx_type     = '-';
        $transaction->details      = 'Pool investment';
        $transaction->trx          = getTrx();
        $transaction->wallet_type  = $wallet;
        $transaction->remark       = 'pool_invest';
        $transaction->save();

        $notify[] = ['success', 'Pool investment added successfully'];
        return back()->withNotify($notify);
    }

}
