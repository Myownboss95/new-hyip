@php
    $promotionCount = App\Models\PromotionTool::count();
@endphp
<div class="dashboard-sidebar" id="dashboard-sidebar">
    <button class="btn-close dash-sidebar-close d-xl-none"></button>
    <a href="{{ route('home') }}" class="logo"><img src="{{ asset(getImage(getFilePath('logoIcon') . '/logo_2.png')) }}" alt="images"></a>
    <div class="bg--lights">
        <div class="profile-info">
            <p class="fs--13px mb-3 fw-bold">@lang('ACCOUNT BALANCE')</p>
            <h4 class="usd-balance text--base mb-2 fs--30">{{ showAmount(auth()->user()->deposit_wallet) }} <sub class="top-0 fs--13px">{{ $general->cur_text }} <small>(@lang('Deposit Wallet'))</small> </sub></h4>
            <p class="btc-balance fw-medium fs--18px">{{ showAmount(auth()->user()->interest_wallet) }} <sub class="top-0 fs--13px">{{ $general->cur_text }} <small>(@lang('Interest Wallet'))</small></sub></p>
            <div class="mt-4 d-flex flex-wrap gap-2">
                <a href="{{ route('user.deposit.index') }}" class="btn btn--base btn--smd">@lang('Deposit')</a>
                <a href="{{ route('user.withdraw') }}" class="btn btn--secondary btn--smd">@lang('Withdraw')</a>
            </div>
        </div>
    </div>
    <ul class="sidebar-menu">
        <li><a href="{{ route('user.home') }}" class="{{ menuActive('user.home') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/dashboard.png') }}" alt="icon"> @lang('Dashboard')</a></li>
        <li><a href="{{ route('user.invest.statistics') }}" class="{{ menuActive(['user.invest.statistics', 'user.invest.log', 'plan', 'user.invest.details']) }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/investment.png') }}" alt="icon"> @lang('Investments')</a></li>
        @if ($general->schedule_invest)
            <li><a href="{{ route('user.invest.schedule') }}" class="{{ menuActive('user.invest.schedule') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/schedule.png') }}" alt="icon"> @lang('Schedule Investment')</a></li>
        @endif
        @if ($general->staking_option)
            <li><a href="{{ route('user.staking.index') }}" class="{{ menuActive('user.staking.index') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/staking.png') }}" alt="icon"> @lang('Staking')</a></li>
        @endif
        @if ($general->pool_option)
            <li><a href="{{ route('user.pool.index') }}" class="{{ menuActive(['user.pool.index', 'user.pool.invests']) }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/pool_invest.png') }}" alt="icon"> @lang('Pool')</a></li>
        @endif
        <li><a href="{{ route('user.deposit.index') }}" class="{{ menuActive('user.deposit*') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/wallet.png') }}" alt="icon"> @lang('Deposit')</a></li>
        <li><a href="{{ route('user.withdraw') }}" class="{{ menuActive('user.withdraw*') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/withdraw.png') }}" alt="icon"> @lang('Withdraw')</a></li>
        @if ($general->b_transfer)
            <li><a href="{{ route('user.transfer.balance') }}" class="{{ menuActive('user.transfer.balance') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/balance-transfer.png') }}" alt="icon"> @lang('Transfer Balance')</a></li>
        @endif
        <li><a href="{{ route('user.transactions') }}" class="{{ menuActive('user.transactions') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/transaction.png') }}" alt="icon"> @lang('Transactions')</a></li>
        @if ($general->user_ranking)
            <li><a href="{{ route('user.invest.ranking') }}" class="{{ menuActive('user.invest.ranking') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/ranking.png') }}" alt="icon"> @lang('Ranking')</a></li>
        @endif
        <li><a href="{{ route('user.referrals') }}" class="{{ menuActive('user.referrals') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/referral.png') }}" alt="icon"> @lang('Referrals')</a></li>
        @if ($general->promotional_tool && $promotionCount)
            <li><a href="{{ route('user.promotional.banner') }}" class="{{ menuActive('user.promotional.banner') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/promotion.png') }}" alt="icon"> @lang('Promotional Banner')</a></li>
        @endif

        <li><a href="{{ route('ticket.index') }}" class="{{ menuActive(['ticket.index', 'ticket.view', 'ticket.open']) }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/ticket.png') }}" alt="icon"> @lang('Support Ticket')</a></li>
        <li><a href="{{ route('user.twofactor') }}" class="{{ menuActive('user.twofactor') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/2fa.png') }}" alt="icon"> @lang('2FA')</a></li>
        <li><a href="{{ route('user.profile.setting') }}" class="{{ menuActive('user.profile.setting') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/profile.png') }}" alt="icon"> @lang('Profile')</a></li>
        <li><a href="{{ route('user.change.password') }}" class="{{ menuActive('user.change.password') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/password.png') }}" alt="icon"> @lang('Change Password')</a></li>
        <li><a href="{{ route('user.logout') }}" class="{{ menuActive('user.logout') }}"><img src="{{ asset($activeTemplateTrue . '/images/icon/logout.png') }}" alt="icon"> @lang('Logout')</a></li>
    </ul>
</div>
