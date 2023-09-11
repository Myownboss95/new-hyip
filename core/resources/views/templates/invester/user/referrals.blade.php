@extends($activeTemplate.'layouts.master')
@section('content')

<div class="dashboard-inner">
    <div class="mb-4">
        <h3>@lang('My Referrals')</h3>
    </div>
    <div class="row gy-4">
        <div class="col-md-12">
            <div class="card mb-3">
                <div class="card-body">
                    <h4 class="mb-1">@lang('Refer & Enjoy the Bonus')</h4>
                    <p class="mb-3">@lang('You\'ll get commission against your referral\'s activities. Level has been decided by the') <strong><i>{{ __($general->site_name) }}</i></strong> @lang('authority. If you reach the level, you\'ll get commission.')</p>
                    <div class="copy-link">
                        <input type="text" class="copyURL" value="{{ route('home') }}?reference={{ auth()->user()->username }}" readonly>
                        <span class="copyBoard" id="copyBoard"><i class="las la-copy"></i> <strong class="copyText">@lang('Copy')</strong></span>
                    </div>
                </div>
            </div>
            @if($user->allReferrals->count() > 0 && $maxLevel > 0)
            <div class="card">
                <div class="card-body">
                    <div class="treeview-container">
                        <ul class="treeview">
                        <li class="items-expanded"> {{ $user->fullname }} ( {{ $user->username }} )
                                @include($activeTemplate.'partials.under_tree',['user'=>$user,'layer'=>0,'isFirst'=>true])
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            @endif
        </div>
    </div>
</div>

@endsection

@push('style')
    <link href="{{ asset('assets/global/css/jquery.treeView.css') }}" rel="stylesheet" type="text/css">
@endpush
@push('script')
<script src="{{ asset('assets/global/js/jquery.treeView.js') }}"></script>
<script>
    (function($){
    "use strict"
        $('.treeview').treeView();
        $('.copyBoard').click(function(){
                var copyText = document.getElementsByClassName("copyURL");
                copyText = copyText[0];
                copyText.select();
                copyText.setSelectionRange(0, 99999);

                /*For mobile devices*/
                document.execCommand("copy");
                $('.copyText').text('Copied');
                setTimeout(() => {
                    $('.copyText').text('Copy');
                }, 2000);
        });
    })(jQuery);
</script>
@endpush
