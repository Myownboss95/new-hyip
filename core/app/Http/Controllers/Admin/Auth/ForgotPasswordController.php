<?php

namespace App\Http\Controllers\Admin\Auth;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\AdminPasswordReset;
use Illuminate\Http\Request;

class ForgotPasswordController extends Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->middleware('admin.guest');
    }

    public function showLinkRequestForm()
    {
        $pageTitle = 'Account Recovery';
        return view('admin.auth.passwords.email', compact('pageTitle'));
    }

    public function sendResetCodeEmail(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email',
        ]);

        if (!verifyCaptcha()) {
            $notify[] = ['error', 'Invalid captcha provided'];
            return back()->withNotify($notify);
        }

        $admin = Admin::where('email', $request->email)->first();
        if (!$admin) {
            return back()->withErrors(['Email Not Available']);
        }

        $code                           = verificationCode(6);
        $adminPasswordReset             = new AdminPasswordReset();
        $adminPasswordReset->email      = $admin->email;
        $adminPasswordReset->token      = $code;
        $adminPasswordReset->created_at = date("Y-m-d h:i:s");
        $adminPasswordReset->save();

        $adminIpInfo  = getIpInfo();
        $adminBrowser = osBrowser();
        notify($admin, 'PASS_RESET_CODE', [
            'code'             => $code,
            'operating_system' => $adminBrowser['os_platform'],
            'browser'          => $adminBrowser['browser'],
            'ip'               => $adminIpInfo['ip'],
            'time'             => $adminIpInfo['time'],
        ], ['email'], false);

        $email = $admin->email;
        session()->put('pass_res_mail', $email);

        return to_route('admin.password.code.verify');
    }

    public function codeVerify()
    {
        $pageTitle = 'Verify Code';
        $email     = session()->get('pass_res_mail');
        if (!$email) {
            $notify[] = ['error', 'Oops! session expired'];
            return to_route('admin.password.reset')->withNotify($notify);
        }
        return view('admin.auth.passwords.code_verify', compact('pageTitle', 'email'));
    }

    public function verifyCode(Request $request)
    {
        $request->validate(['code' => 'required']);
        $notify[] = ['success', 'You can change your password.'];
        $code     = str_replace(' ', '', $request->code);
        return to_route('admin.password.reset.form', $code)->withNotify($notify);
    }
}
