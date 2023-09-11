<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\UserRanking;
use App\Rules\FileTypeValidate;
use Illuminate\Http\Request;

class RankingController extends Controller
{
    function list() {
        $pageTitle    = 'User Rankings';
        $userRankings = UserRanking::paginate(getPaginate());

        return view('admin.user_ranking.list', compact('pageTitle', 'userRankings'));
    }

    public function store(Request $request, $id = 0)
    {
        $validateRule = $id ? 'nullable' : 'required';
        $request->validate([
            'level'               => 'required|integer:gt:0',
            'name'                => 'required',
            'minimum_invest'      => 'required|numeric|gt:0',
            'team_minimum_invest' => 'required|numeric|gt:0',
            'min_referral'        => 'required|integer|gt:0',
            'bonus'               => 'required|numeric|min:0',
            'icon'                => [$validateRule, 'image', new FileTypeValidate(['jpg', 'jpeg', 'png'])],
        ]);

        if ($id) {
            $userRanking = UserRanking::findOrFail($id);
            $notify[]    = ['success', 'User ranking updated successfully'];
        } else {
            $userRanking = new UserRanking();
            $notify[]    = ['success', 'User ranking added successfully'];
        }

        if ($request->hasFile('icon')) {
            try {
                $userRanking->icon = fileUploader($request->icon, getFilePath('userRanking'), getFileSize('userRanking'), $userRanking->icon);
            } catch (\Exception$exp) {
                $notify[] = ['error', 'Couldn\'t upload your icon'];
                return back()->withNotify($notify);
            }
        }

        $userRanking->level               = $request->level;
        $userRanking->name                = $request->name;
        $userRanking->minimum_invest      = $request->minimum_invest;
        $userRanking->min_referral_invest = $request->team_minimum_invest;
        $userRanking->min_referral        = $request->min_referral;
        $userRanking->bonus               = $request->bonus;
        $userRanking->save();

        return back()->withNotify($notify);
    }

    public function status($id)
    {
        return UserRanking::changeStatus($id);
    }

}
