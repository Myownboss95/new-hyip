<div class="dashboard-nav d-flex flex-wrap align-items-center justify-content-between">
    <div class="nav-left d-flex gap-4 align-items-center">
        <div class="dash-sidebar-toggler d-xl-none" id="dash-sidebar-toggler">
            <i class="fas fa-bars"></i>
        </div>
    </div>
    <div class="nav-right d-flex flex-wrap align-items-center gap-3">
        @if (auth()->user()->userRanking && $general->user_ranking)
            <span class="rang-user" data-bs-toggle="tooltip" data-bs-title="@lang('Your current rank is ' . auth()->user()->userRanking->name)"><img src="{{ getImage(getFilePath('userRanking') . '/' . auth()->user()->userRanking->icon, getFileSize('userRanking')) }}" alt="">
            </span>
        @endif
        @if ($general->language_switch)
            @php
                $language = App\Models\Language::all();
            @endphp
            <select name="langSel" class="langSel form--control h-auto px-2 py-1 border-0">
                @foreach ($language as $item)
                    <option value="{{ $item->code }}" @if (session('lang') == $item->code) selected @endif>{{ __($item->name) }}</option>
                @endforeach
            </select>
        @endif
        <ul class="nav-header-link d-flex flex-wrap gap-2">
            <li>
                <a class="link" href="javascript:void(0)">{{ getInitials(auth()->user()->fullname) }}</a>
                <div class="dropdown-wrapper">
                    <div class="dropdown-header">
                        <h6 class="name text--base">{{ auth()->user()->fullname }}</h6>
                        <p class="fs--14px">{{ auth()->user()->username }}</p>
                    </div>
                    <ul class="links">
                        <li><a href="{{ route('user.profile.setting') }}"><i class="las la-user"></i> @lang('Profile')</a></li>
                        <li><a href="{{ route('user.change.password') }}"><i class="las la-key"></i> @lang('Change Password')</a></li>
                        <li><a href="{{ route('user.logout') }}"><i class="las la-sign-out-alt"></i> @lang('Logout')</a></li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
</div>
@push('script')
    <script>
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    </script>
@endpush
