<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Pool;
use App\Models\PoolInvest;
use App\Models\Staking;
use App\Models\StakingInvest;
use App\Models\Transaction;
use Illuminate\Http\Request;

class StakingPoolController extends Controller
{
    public function staking()
    {
        $pageTitle = 'Manage Staking';
        $stakings  = Staking::orderBy('days')->paginate(getPaginate());
        return view('admin.staking.list', compact('pageTitle', 'stakings'));
    }

    public function saveStaking(Request $request, $id = 0)
    {
        $request->validate([
            'duration'        => 'required|integer|min:1',
            'interest_amount' => 'required|numeric|gt:0',
        ]);

        if ($id) {
            $staking      = Staking::findOrFail($id);
            $notification = 'updated';
        } else {
            $staking      = new Staking();
            $notification = 'added';
        }

        $staking->days             = $request->duration;
        $staking->interest_percent = $request->interest_amount;
        $staking->save();

        $notify[] = ['success', "Staking $notification successfully"];
        return back()->withNotify($notify);
    }

    public function stakingStatus($id)
    {
        return Staking::changeStatus($id);
    }

    public function stakingInvest()
    {
        $pageTitle      = 'All Staking Invest';
        $stakingInvests = StakingInvest::searchable(['user:username'])->with('user')->orderBy('id', 'desc')->paginate(getPaginate());

        return view('admin.staking.invest', compact('pageTitle', 'stakingInvests'));
    }

    public function pool()
    {
        $pageTitle = 'Manage Pool';
        $pools     = Pool::orderBy('id', 'desc')->paginate(getPaginate());

        return view('admin.pool.list', compact('pageTitle', 'pools'));
    }

    public function savePool(Request $request, $id = 0)
    {
        $request->validate([
            'name'           => 'required',
            'amount'         => 'required|numeric|gt:0',
            'interest_range' => 'required',
            'start_date'     => 'required|date|date_format:Y-m-d\TH:i|after_or_equal:now',
            'end_date'       => 'required|date|date_format:Y-m-d\TH:i|after:start_date',
        ]);

        if ($id) {
            $pool         = Pool::findOrFail($id);
            $notification = 'updated';
            if($pool->share_interest){
                $notify[]=['error','Pool interest already dispatch! Unable to update.'];
                return back()->withNotify($notify);
            }
        } else {
            $pool         = new Pool();
            $notification = 'added';
        }

        $pool->name           = $request->name;
        $pool->amount         = $request->amount;
        $pool->interest_range = $request->interest_range;
        $pool->start_date     = $request->start_date;
        $pool->end_date       = $request->end_date;
        $pool->save();

        $notify[] = ['success', "Pool $notification successfully"];
        return back()->withNotify($notify);
    }

    public function poolStatus($id)
    {
        return Pool::changeStatus($id);
    }

    public function dispatchPool(Request $request)
    {
        $request->validate([
            'pool_id' => 'required|integer',
            'amount'  => 'required|numeric|gt:0',
        ]);

        $pool = Pool::with('poolInvests.user')->findOrFail($request->pool_id);

        if ($pool->end_date > now()) {
            $notify[] = ['error', 'You can dispatch interest after end date'];
            return back()->withNotify($notify);
        }

        if ($pool->share_interest == 1) {
            $notify[] = ['error', 'Interest already dispatched for this pool'];
            return back()->withNotify($notify);
        }

        $pool->share_interest = 1;
        $pool->interest       = $request->amount;
        $pool->save();

        foreach ($pool->poolInvests as $poolInvest) {
            $investAmount = $poolInvest->invest_amount;
            $interest     = $investAmount * $request->amount / 100;

            $user = $poolInvest->user;
            $user->interest_wallet += $investAmount + $interest;
            $user->save();

            $poolInvest->status = 2;
            $poolInvest->save();

            $transaction               = new Transaction();
            $transaction->user_id      = $user->id;
            $transaction->amount       = $investAmount + $interest;
            $transaction->post_balance = $user->interest_wallet;
            $transaction->charge       = 0;
            $transaction->trx_type     = '+';
            $transaction->details      = 'Pool invested return';
            $transaction->trx          = getTrx();
            $transaction->wallet_type  = 'interest_wallet';
            $transaction->remark       = 'pool_invest_return';
            $transaction->save();
        }

        $notify[] = ['success', 'Pool dispatched successfully'];
        return back()->withNotify($notify);
    }

    public function poolInvest()
    {
        $pageTitle   = 'All Pool Invest';
        $poolInvests = PoolInvest::searchable(['user:username', 'pool:name'])->with('user', 'pool')->orderBy('id', 'desc')->paginate(getPaginate());
        return view('admin.pool.invest', compact('pageTitle', 'poolInvests'));
    }

}
