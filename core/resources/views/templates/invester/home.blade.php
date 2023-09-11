@extends($activeTemplate . 'layouts.frontend')
@section('content')
    @php
        $plans = App\Models\Plan::with('timeSetting')
            ->whereHas('timeSetting', function ($time) {
                $time->where('status', 1);
            })
            ->where('status', 1)
            ->where('featured', 1)
            ->get();
        $gatewayCurrency = null;
        if (auth()->check()) {
            $gatewayCurrency = App\Models\GatewayCurrency::whereHas('method', function ($gate) {
                $gate->where('status', 1);
            })
                ->with('method')
                ->orderby('method_code')
                ->get();
        }
    @endphp

    <section class="plan-section pt-120 pb-120 bg--light">
        <div class="container">
            <div class="row gy-4 justify-content-center">
                @include($activeTemplate . 'partials.plan', ['plans' => $plans])
            </div>

            @php
                $workProcess = getContent('how_it_work.content', true);
                $workProcessElements = getContent('how_it_work.element', null, false, true);
            @endphp

            <div class="how-it-work pt-5">
                <div class="mb-3">
                    <h4>{{ __(@$workProcess->data_values->title) }}</h4>
                    <p>@php echo __(@$workProcess->data_values->subtitle) @endphp</p>
                </div>
                <div class="row gy-4">
                    @foreach ($workProcessElements as $process)
                        <div class="col-md-3 col-sm-6">
                            <div class="work-process-card">
                                <div class="icon-area">
                                    <img src="{{ getImage('assets/images/frontend/how_it_work/' . $process->data_values->image, '50x50') }}" alt="">
                                </div>
                                <h5 class="my-1">{{ __($process->data_values->title) }}</h5>
                                <p>{{ __($process->data_values->content) }}</p>
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </section>

    @if ($general->user_ranking)
        @php
            $userRanking = getContent('ranking.content', true);
            $userRankings = App\Models\UserRanking::active()->get();
        @endphp

        @if ($userRankings->count())
            <section class="referral-level-section border-top-1 pt-120 pb-120">
                <div class="container">
                    <div class="mb-3">
                        <h4>{{ __($userRanking->data_values->heading) }}</h4>
                        <p>{{ __($userRanking->data_values->sub_heading) }}</p>
                    </div>
                    <div class="referral__level__area">
                        @php
                            $firstPercent = 20;
                            $lastPercent = 100;
                            $perItem = ($lastPercent - $firstPercent) / ($userRankings->count() > 1 ? $userRankings->count() - 1 : $userRankings->count());
                        @endphp
                        @foreach ($userRankings as $rank)
                            <div class="referral__level__item">
                                <div class="referral__level__item__inner">
                                    <div class="referral__left">
                                        <div class="referral__level__thumb">
                                            <img src="{{ getImage(getFilePath('userRanking') . '/' . $rank->icon, getFileSize('userRanking')) }}" alt="referral">
                                        </div>
                                        <div class="referral__level__name">
                                            {{ __($rank->name) }}
                                        </div>
                                    </div>
                                    <div class="referral__right">
                                        <div class="referral__level__content custom-width" data-custom_width="{{ $perItem * $loop->index + $firstPercent }}">
                                            <div class="referral__level__content__content">
                                                <span><i class="las la-coins"></i> @lang('Bonus'): {{ $general->cur_sym }}{{ showAmount($rank->bonus) }}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="referral__tooltip">
                                    <ul>
                                        <li class="d-flex justify-content-between">
                                            @lang('Level')
                                            <span>{{ __($rank->level) }}</span>
                                        </li>
                                        <li class="d-flex justify-content-between">
                                            @lang('Minimum Invest')
                                            <span>{{ $general->cur_sym }}{{ showAmount($rank->minimum_invest) }}</span>
                                        </li>
                                        <li class="d-flex justify-content-between">
                                            @lang('Team Invest')
                                            <span>{{ $general->cur_sym }}{{ showAmount($rank->min_referral_invest) }}</span>
                                        </li>
                                        <li class="d-flex justify-content-between">
                                            @lang('No. of Direct Referral')
                                            <span>{{ $rank->min_referral }}</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </section>
        @endif
    @endif
@endsection

@if ($general->user_ranking)
    @push('script')
        <script>
            (function($) {
                "use strict";
                $('.custom-width').each(function(index, value) {
                    $(value).css("max-width", `${$(value).data('custom_width')}%`);
                });
            })(jQuery);
        </script>
    @endpush
@endif
