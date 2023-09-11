@extends($activeTemplate . 'layouts.master')
@section('content')
    <section class="pt-150 pb-150">
        <div class="container">
            <div class="row justify-content-center gy-4">
                @php $nextRanking = $userRankings->where('id', '>', $user->user_ranking_id)->first(); @endphp
                @if ($nextRanking)
                    <div class="col-md-12">
                        <div class="card card-bg custom--card">
                            <div class="card-body">
                                <div class="row gy-4 align-items-center">
                                    <div class="col-lg-4 col-md-7">
                                        <div class="d-flex align-items-center raking-invest">
                                            <img src="{{ getImage(getFilePath('userRanking') . '/' . $nextRanking->icon, getFileSize('userRanking')) }}" alt="image">
                                            <div class="text-md-start">
                                                <span>@lang('My Invest')</span>
                                                <h5>{{ $general->cur_sym }}{{ showAmount($user->total_invests) }} / {{ $general->cur_sym }}{{ showAmount($nextRanking->minimum_invest) }}</h6>
                                                    @if ($nextRanking->minimum_invest - $user->total_invests > 0)
                                                        <span>{{ $general->cur_sym }}{{ showAmount($nextRanking->minimum_invest - $user->total_invests) }} @lang('To unlock')</span>
                                                    @endif
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-5">
                                        <div class="raking-common text-center">
                                            <span>@lang('No. of Direct Referral')</span>
                                            <h5>{{ $user->activeReferrals->count() }} / {{ $nextRanking->min_referral }}</h5>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-7">
                                        <div class="raking-common text-center">
                                            <span>@lang('Team Invest')</span>
                                            <h5>{{ $general->cur_sym }}{{ showAmount($user->team_invests) }} / {{ $general->cur_sym }}{{ showAmount($nextRanking->min_referral_invest) }}</h5>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-5">
                                        <div class="raking-common text-center">
                                            <span>@lang('Bonus')</span>
                                            <h5>{{ $general->cur_sym }}{{ showAmount($nextRanking->bonus) }}</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                @endif

                <div class="col-md-12">
                    <div class="row gy-4">
                        @foreach ($userRankings as $userRanking)
                            @if ($user->user_ranking_id >= $userRanking->id)
                                @php $progressPercent = 100; @endphp
                            @else
                                @php
                                    $myInvestPercent = ($user->total_invests / $userRanking->minimum_invest) * 100;
                                    $refInvestPercent = ($user->team_invests / $userRanking->min_referral_invest) * 100;
                                    $refCountPercent = ($user->activeReferrals->count() / $userRanking->min_referral) * 100;
                                    
                                    $myInvestPercent = $myInvestPercent < 100 ? $myInvestPercent : 100;
                                    $refInvestPercent = $refInvestPercent < 100 ? $refInvestPercent : 100;
                                    $refCountPercent = $refCountPercent < 100 ? $refCountPercent : 100;
                                    $progressPercent = ($myInvestPercent + $refInvestPercent + $refCountPercent) / 3;
                                @endphp
                            @endif
                            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6">
                                <div class="invest-badge text-center">
                                    <div class="invest-badge__thumb">
                                        <div class="invest-badge__thumb__mask {{ $nextRanking->id < $userRanking->id ? 'badge-lock' : '' }}" data-progress="{{ $nextRanking->id < $userRanking->id ? 0 : $progressPercent }}">
                                            <img src="{{ getImage(getFilePath('userRanking') . '/' . $userRanking->icon, getFileSize('userRanking')) }}" alt="image">
                                        </div>
                                    </div>
                                    <h4 class="invest-badge__title">
                                        {{ __($userRanking->name) }}
                                    </h4>
                                    <p class=invest-badge__subtitle>@lang('Bonus') - {{ $general->cur_sym }}{{ showAmount($userRanking->bonus) }}</p>
                                    <ul class="invest-badge__list invest-badge__details  invest-badge__details-{{ $loop->iteration % 4 == 0 ? 4 : $loop->iteration % 4 }} {{ $loop->iteration % 3 == 0 ? 'invest-badge__detail_one' : 'invest-badge__detail_two' }}">
                                        <li class="d-flex "><span>@lang('Level')</span>
                                            <span>: {{ $userRanking->level }}</span>
                                        </li>
                                        <li class="d-flex "><span>@lang('Minimum Invest')</span>
                                            <span>: {{ $general->cur_sym }}{{ showAmount($userRanking->minimum_invest) }}</span>
                                        </li>
                                        <li class="d-flex "><span>@lang('No. of Direct Referral')</span>
                                            <span>: {{ $userRanking->min_referral }}</span>
                                        </li>
                                        <li class="d-flex "><span>@lang('Referral Invest')</span>
                                            <span>: {{ $general->cur_sym }}{{ showAmount($userRanking->min_referral_invest) }}</span>
                                        </li>
                                        <li class="d-flex "><span>@lang('Bonus')</span>
                                            <span>: {{ $general->cur_sym }}{{ showAmount($userRanking->bonus) }}</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection

@push('script')
    <script>
        (function($) {
            "use strict";

            var elements = $('.invest-badge__thumb__mask');
            elements.each(function(index, element) {
                let progress = $(element).data('progress');
                element.style.setProperty('--before-height', `${progress}%`);
            });

        })(jQuery);
    </script>
@endpush
