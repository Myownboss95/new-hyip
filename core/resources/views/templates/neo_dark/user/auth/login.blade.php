@extends($activeTemplate . 'layouts.frontend')
@section('content')
    @php
    $loginContent = getContent('login.content', true);
    @endphp

    <div class="signin-wrapper">
        <div class="outset-circle"></div>
        <div class="container">
            <div class="row justify-content-lg-between align-items-center">
                <div class="col-xl-5 col-lg-6">
                    <div class="signin-thumb">
                        <img src="{{ getImage('assets/images/frontend/login/' . @$loginContent->data_values->image) }}" alt="image">
                    </div>
                </div>
                <div class="col-xl-5 col-lg-6">
                    <div class="signin-form-area">
                        <h3 class="title text-capitalize text-shadow mb-30">{{ __($pageTitle) }}</h3>
                        <button class="btn btn-success btn-small w-100 mb-3 btn-primary metamaskLogin"><img src="{{ asset($activeTemplateTrue.'images/metamask.png') }}" alt="@lang('image')" class="metamask-image"> @lang('Login with Metamask')</button>
                        <form class="signin-form verify-gcaptcha" action="{{ route('user.login') }}" method="post">
                            @csrf
                            <div class="form-group">
                                <label class="form-label">@lang('Username')</label>
                                <input  type="text" name="username" id="signin_name" placeholder="@lang('Username or Email')" value="{{ old('username') }}" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label">@lang('Password')</label>
                                <input type="password" name="password" id="signin_pass" placeholder="@lang('Password')" required autocomplete="current-password" required>
                            </div>

                            <x-captcha />

                            <div class="custom--checkbox mb-3">
                                <input class="w-auto h-auto" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>
                                <label class="mb-0" for="remember">
                                    @lang('Remember Me')
                                </label>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success btn-small w-100 btn-primary">@lang('Sign In')</button>
                            </div>
                            <p>{{ trans('Forgot Your Password?') }}
                                <a href="{{ route('user.password.request') }}" class="label-text base--color">@lang('Reset Now')</a>
                            </p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script-lib')
    <script src="{{ asset('assets/global/js/web3.min.js') }}"></script>
@endpush

@push('script')
    <script>
        var account = null;
        var signature = null;
        var message = 'Sign in koro';
        var token = null;
        $('.metamaskLogin').on('click', async () => {
            // detect wallet
            if (!window.ethereum) {
                notify('error', 'MetaMask not detected. Please install MetaMask first.');
                return;
            }

            // get wallet address
            await window.ethereum.request({
                method: 'eth_requestAccounts'
            });
            window.web3 = new Web3(window.ethereum);
            accounts = await web3.eth.getAccounts();
            account = accounts[0];

            // get unique message
            let response = await fetch(`{{ route('user.login.metamask') }}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    'account': account,
                    '_token': '{{ csrf_token() }}'
                })
            });
            message = (await response.json()).message;
            setTimeout(async () => {
                // get signature
                signature = await web3.eth.personal.sign(message, account);

                // verify signature
                response = await fetch(`{{ route('user.login.metamask.verify') }}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        'signature': signature,
                        '_token': '{{ csrf_token() }}'
                    })
                });
                response = await response.json();

                notify(response.type, response.message);

                // handle login
                if (response.type == 'success') {
                    setTimeout(() => {
                        window.location.href = response.redirect_url;
                    }, 2000);
                }
            }, 1500);

        })
    </script>
@endpush