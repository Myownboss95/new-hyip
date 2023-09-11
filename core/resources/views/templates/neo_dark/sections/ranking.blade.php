@if ($general->user_ranking)
    @php
        $userRanking = getContent('ranking.content', true);
        $userRankings = App\Models\UserRanking::active()->get();
    @endphp

    @if ($userRankings->count())
        <section class="referral-level-section border-top-1 pt-120 pb-120">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="section-header text-center">
                            <h2 class="section__title">{{ __(@$userRanking->data_values->heading) }}</h2>
                            <p>{{ __(@$userRanking->data_values->sub_heading) }}</p>
                        </div>
                    </div>
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
                                    <div class="referral__level__content custom-width"data-custom_width="{{ $perItem * $loop->index + $firstPercent }}">
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
