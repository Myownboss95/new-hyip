<?php

namespace App\Http\Controllers\User\Auth;

use App\Http\Controllers\Controller;
use App\Models\AdminNotification;
use App\Models\User;
use App\Models\UserLogin;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
use Elliptic\EC;
use kornrunner\Keccak;
use Illuminate\Support\Str;


class LoginController extends Controller
{
    use AuthenticatesUsers;

    protected $username;

    public function __construct()
    {
        parent::__construct();
        $this->middleware('guest')->except('logout');
        $this->username = $this->findUsername();
    }

    public function showLoginForm()
    {
        $pageTitle = "Login";
        return view($this->activeTemplate . 'user.auth.login', compact('pageTitle'));
    }

    public function login(Request $request)
    {

        $this->validateLogin($request);

        $request->session()->regenerateToken();

        if (!verifyCaptcha()) {
            $notify[] = ['error', 'Invalid captcha provided'];
            return back()->withNotify($notify);
        }

        // If the class is using the ThrottlesLogins trait, we can automatically throttle
        // the login attempts for this application. We'll key this by the username and
        // the IP address of the client making these requests into this application.
        if ($this->hasTooManyLoginAttempts($request)) {
            $this->fireLockoutEvent($request);

            return $this->sendLockoutResponse($request);
        }

        if ($this->attemptLogin($request)) {
            return $this->sendLoginResponse($request);
        }

        // If the login attempt was unsuccessful we will increment the number of attempts
        // to login and redirect the user back to the login form. Of course, when this
        // user surpasses their maximum number of attempts they will get locked out.
        $this->incrementLoginAttempts($request);

        return $this->sendFailedLoginResponse($request);
    }

    public function findUsername()
    {
        $login = request()->input('username');

        $fieldType = filter_var($login, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';
        request()->merge([$fieldType => $login]);
        return $fieldType;
    }

    public function username()
    {
        return $this->username;
    }

    protected function validateLogin(Request $request)
    {

        $request->validate([
            $this->username() => 'required|string',
            'password'        => 'required|string',
        ]);

    }

    public function logout()
    {
        $this->guard()->logout();

        request()->session()->invalidate();

        $notify[] = ['success', 'You have been logged out.'];
        return to_route('user.login')->withNotify($notify);
    }

    public function authenticated(Request $request, $user)
    {
        $user->tv = $user->ts == 1 ? 0 : 1;
        $user->save();
        $ip        = getRealIP();
        $exist     = UserLogin::where('user_ip', $ip)->first();
        $userLogin = new UserLogin();
        if ($exist) {
            $userLogin->longitude    = $exist->longitude;
            $userLogin->latitude     = $exist->latitude;
            $userLogin->city         = $exist->city;
            $userLogin->country_code = $exist->country_code;
            $userLogin->country      = $exist->country;
        } else {
            $info                    = json_decode(json_encode(getIpInfo()), true);
            $userLogin->longitude    = @implode(',', $info['long']);
            $userLogin->latitude     = @implode(',', $info['lat']);
            $userLogin->city         = @implode(',', $info['city']);
            $userLogin->country_code = @implode(',', $info['code']);
            $userLogin->country      = @implode(',', $info['country']);
        }

        $userAgent          = osBrowser();
        $userLogin->user_id = $user->id;
        $userLogin->user_ip = $ip;

        $userLogin->browser = @$userAgent['browser'];
        $userLogin->os      = @$userAgent['os_platform'];
        $userLogin->save();

        return to_route('user.home');
    }

    public function metamaskLogin(Request $request)
    {
        $nonce   = getTrx(16);
        $message = "Sign this message to confirm you own this wallet address. This action will not cost any gas fees. Nonce: $nonce";
        session()->put('sign_in_data', ['wallet' => $request->account, 'nonce' => $nonce, 'message' => $message]);
        return response()->json(['message' => $message]);
    }
    public function metamaskLoginVerify(Request $request)
    {
        $wallet = session('sign_in_data')['wallet'];
        $result = $this->verifySignature(session('sign_in_data')['message'], $request->signature, $wallet);
        if ($result) {
            $user = User::where('wallet', $wallet)->first();
            if (!$user) {
                $user          = new User();
                $user->wallet  = $wallet;
                $user->message = session('sign_in_data')['nonce'];
                $user->save();

                $adminNotification            = new AdminNotification();
                $adminNotification->user_id   = $user->id;
                $adminNotification->title     = 'New member registered';
                $adminNotification->click_url = urlPath('admin.users.detail', $user->id);
                $adminNotification->save();
            }

            auth()->login($user);

            //Login Log Create
            $ip        = getRealIP();
            $exist     = UserLogin::where('user_ip', $ip)->first();
            $userLogin = new UserLogin();

            //Check exist or not
            if ($exist) {
                $userLogin->longitude    = $exist->longitude;
                $userLogin->latitude     = $exist->latitude;
                $userLogin->city         = $exist->city;
                $userLogin->country_code = $exist->country_code;
                $userLogin->country      = $exist->country;
            } else {
                $info                    = json_decode(json_encode(getIpInfo()), true);
                $userLogin->longitude    = @implode(',', $info['long']);
                $userLogin->latitude     = @implode(',', $info['lat']);
                $userLogin->city         = @implode(',', $info['city']);
                $userLogin->country_code = @implode(',', $info['code']);
                $userLogin->country      = @implode(',', $info['country']);
            }

            $userAgent          = osBrowser();
            $userLogin->user_id = $user->id;
            $userLogin->user_ip = $ip;

            $userLogin->browser = @$userAgent['browser'];
            $userLogin->os      = @$userAgent['os_platform'];
            $userLogin->save();

            $response = [
                'type'         => 'success',
                'message'      => 'Login successful',
                'redirect_url' => route('user.home'),
            ];
        } else {
            $response = [
                'type'    => 'error',
                'message' => 'Login failed',
            ];
        }
        return response()->json($response);
    }

    protected function verifySignature(string $message, string $signature, string $address): bool
    {
        $hash = Keccak::hash(sprintf("\x19Ethereum Signed Message:\n%s%s", strlen($message), $message), 256);
        $sign = [
            'r' => substr($signature, 2, 64),
            's' => substr($signature, 66, 64),
        ];
        $recid = ord(hex2bin(substr($signature, 130, 2))) - 27;

        if ($recid != ($recid&1)) {
            return false;
        }

        $pubkey          = (new EC('secp256k1'))->recoverPubKey($hash, $sign, $recid);
        $derived_address = '0x' . substr(Keccak::hash(substr(hex2bin($pubkey->encode('hex')), 1), 256), 24);

        return (Str::lower($address) === $derived_address);
    }

}
