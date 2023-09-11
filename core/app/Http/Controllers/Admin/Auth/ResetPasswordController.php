<?php

namespace App\Http\Controllers\Admin\Auth;

use App\Models\Admin;
use App\Models\AdminPasswordReset;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\ResetsPasswords;
use Illuminate\Support\Facades\Password;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class ResetPasswordController extends Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->middleware('admin.guest');
    }

    public function showResetForm(Request $request, $token)
    {
        $pageTitle = "Account Recovery";
        $resetToken = AdminPasswordReset::where('token', $token)->where('status', 1)->first();

        if (!$resetToken) {
            $notify[] = ['error', 'Verification code mismatch'];
            return to_route('admin.password.reset')->withNotify($notify);
        }
        $email = $resetToken->email;
        return view('admin.auth.passwords.reset', compact('pageTitle', 'email', 'token'));
    }


    public function reset(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email',
            'token' => 'required',
            'password' => 'required|confirmed|min:4',
        ]);

        $reset = AdminPasswordReset::where('token', $request->token)->orderBy('created_at', 'desc')->first();
        $admin = Admin::where('email', $reset->email)->first();
        if ($reset->status == 0) {
            $notify[] = ['error', 'Invalid code'];
            return to_route('admin.login')->withNotify($notify);
        }

        $admin->password = Hash::make($request->password);
        $admin->save();
        $reset->status = 1;
        $reset->save();

        $ipInfo = getIpInfo();
        $browser = osBrowser();
        notify($admin, 'PASS_RESET_DONE', [
            'operating_system' => $browser['os_platform'],
            'browser' => $browser['browser'],
            'ip' => $ipInfo['ip'],
            'time' => $ipInfo['time']
        ],['email'],false);

        $notify[] = ['success', 'Password changed'];
        return to_route('admin.login')->withNotify($notify);
    }
    
}
