<div class="plan-list d-flex flex-wrap flex-xxl-column gap-3 gap-xxl-0">
    @forelse($invests as $invest)
        @php
            if ($invest->last_time) {
                $start = $invest->last_time;
            } else {
                $start = $invest->created_at;
            }
        @endphp
        <div class="plan-item-two">
            <div class="plan-info plan-inner-div">
                <div class="d-flex align-items-center gap-3">
                    @if ($invest->status == 1)
                        <svg class="custom-progress">
                            <circle class="progress-circle" cx="20" cy="22" r="16" style="stroke-dasharray: 100; stroke-dashoffset: calc(100 - (({{ diffDatePercent($start, $invest->next_time) }} * 100)/100))" ; />
                            <circle class="bg-circle" cx="20" cy="22" r="16" style="stroke-dasharray: 100; stroke-dashoffset: 0"; />
                        </svg>
                    @endif

                    <div class="plan-name-data">
                        <div class="plan-name fw-bold">{{ __($invest->plan->name) }} - @lang('Every') {{ __($invest->time_name) }} {{ $invest->plan->interest_type != 1 ? $general->cur_sym : '' }}{{ showAmount($invest->plan->interest) }}{{ $invest->plan->interest_type == 1 ? '%' : '' }}
                            @lang('for') @if ($invest->plan->lifetime == 0)
                                {{ __($invest->plan->repeat_time) }} {{ __($invest->plan->timeSetting->name) }}
                            @else
                                @lang('LIFETIME')
                            @endif
                        </div>
                        <div class="plan-desc">@lang('Invested'): <span class="fw-bold">{{ showAmount($invest->amount) }} {{ $general->cur_text }} @if ($invest->capital_status)
                                    <small class="capital-back"><i>(@lang('Capital will be back'))</i></small>
                                @endif </span></div>
                    </div>
                </div>
            </div>
            <div class="plan-start plan-inner-div">
                <p class="plan-label">@lang('Start Date')</p>
                <p class="plan-value date">{{ showDateTime($invest->created_at, 'M d, Y h:i A') }}</p>
            </div>
            <div class="plan-inner-div">
                <p class="plan-label">@lang('Next Return')</p>
                <p class="plan-value">{{ showDateTime($invest->next_time, 'M d, Y h:i A') }}</p>
            </div>
            <div class="plan-inner-div text-end">
                <p class="plan-label">@lang('Total Return')</p>
                <p class="plan-value amount">
                    @if ($invest->compound_times)
                        {{ $invest->return_rec_time }} @lang('times') | {{ showAmount($invest->paid) }} {{ $general->cur_text }}
                    @else
                        {{ $invest->return_rec_time }}x{{ showAmount($invest->interest) }} = {{ showAmount($invest->paid) }} {{ __($general->cur_text) }}
                    @endif
                </p>
            </div>
            <div class="plan-inner-div text-end justify-content-end">
                <a href="{{ route('user.invest.details', encrypt($invest->id)) }}" class="invest-details-link">
                    <i class="las la-angle-right"></i>
                </a>
                @if ($invest->eligibleCapitalBack())
                    <button class="invest-details-link bg-transparent manageCapital" data-id="{{ $invest->id }}">
                        <i class="las la-hand-holding-usd"></i>
                    </button>
                @endif
            </div>
        </div>
    @empty
        <div class="accordion-body text-center bg-white p-4">
            <h4 class="text--muted"><i class="far fa-frown"></i> {{ __($emptyMessage) }}</h4>
        </div>
    @endforelse
</div>

<div class="modal fade" id="capitalModal">
    <div class="modal-dialog modal-dialog-centered modal-content-bg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">@lang('Manage Invest Capital')</h5>
                <button type="button" class="close" data-bs-dismiss="modal">
                    <i class="las la-times"></i>
                </button>
            </div>
            <form action="{{ route('user.invest.capital.manage') }}" method="post">
                @csrf
                <input type="hidden" name="invest_id">
                <div class="modal-body">
                    <div class="form-group">
                        <label>@lang('Investment Capital')</label>
                        <select name="capital" class="form-control form--control form-select">
                            <option value="reinvest">@lang('Reinvest')</option>
                            <option value="capital_back">@lang('Capital Back')</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn--base w-100">@lang('Submit')</button>
                </div>
            </form>
        </div>
    </div>
</div>

@push('style')
    <style>
        .custom-progress {
            max-width: 40px !important;
            max-height: 40px;
            transform: rotate(-90deg);
        }

        .custom-progress .bg-circle {
            stroke: #00000011;
            fill: none;
            stroke-width: 4px;
            position: relative;
            z-index: -1;
        }

        .custom-progress .progress-circle {
            fill: none;
            stroke: hsl(var(--base));
            stroke-width: 4px;
            z-index: 11;
            position: absolute;
        }

        .expired-time-circle {
            position: relative;
            border: none !important;
            height: 38px;
            width: 38px;
            margin-right: 7px;
        }

        .expired-time-circle::before {
            position: absolute;
            content: '';
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 4px solid #dbdce1;
        }

        .expired-time-circle.danger-border .animation-circle {
            border-color: hsl(var(--base)) !important;
        }

        .animation-circle {
            position: absolute;
            top: 0;
            left: 0;
            border: 4px solid hsl(var(--base));
            height: 100%;
            width: 100%;
            border-radius: 150px;
            transform: rotateY(180deg);
            animation-name: clipCircle;
            animation-iteration-count: 1;
            animation-timing-function: cubic-bezier(0, 0, 1, 1);
            z-index: 1;
        }

        .account-wrapper .left .top {
            margin-top: 0;
        }

        .account-wrapper .left,
        .account-wrapper .right {
            width: 100%;
        }

        .account-wrapper .right {
            padding-left: 0;
            margin-top: 35px;
        }

        @keyframes clipCircle {
            0% {
                clip-path: polygon(50% 50%, 50% 0%, 50% 0%, 50% 0%, 50% 0%, 50% 0%, 50% 0%, 50% 0%, 50% 0%, 50% 0%);
                /* center, top-center*/
            }

            12.5% {
                clip-path: polygon(50% 50%, 50% 0%, 0% 0%, 0% 0%, 0% 0%, 0% 0%, 0% 0%, 0% 0%, 0% 0%, 0% 0%);
                /* center, top-center, top-left*/
            }

            25% {
                clip-path: polygon(50% 50%, 50% 0%, 0% 0%, 0% 50%, 0% 50%, 0% 50%, 0% 50%, 0% 50%, 0% 50%, 0% 50%);
                /* center, top-center, top-left, left-center*/
            }

            37.5% {
                clip-path: polygon(50% 50%, 50% 0%, 0% 0%, 0% 50%, 0% 100%, 0% 100%, 0% 100%, 0% 100%, 0% 100%, 0% 100%);
                /* center, top-center, top-left, left-center, bottom-left*/
            }

            50% {
                clip-path: polygon(50% 50%, 50% 0%, 0% 0%, 0% 50%, 0% 100%, 50% 100%, 50% 100%, 50% 100%, 50% 100%, 50% 100%);
                /* center, top-center, top-left, left-center, bottom-left, bottom-center*/
            }

            62.5% {
                clip-path: polygon(50% 50%, 50% 0%, 0% 0%, 0% 50%, 0% 100%, 50% 100%, 100% 100%, 100% 100%, 100% 100%, 100% 100%);
                /* center, top-center, top-left, left-center, bottom-left, bottom-center, bottom-right*/
            }

            75% {
                clip-path: polygon(50% 50%, 50% 0%, 0% 0%, 0% 50%, 0% 100%, 50% 100%, 100% 100%, 100% 50%, 100% 50%, 100% 50%);
                /* center, top-center, top-left, left-center, bottom-left, bottom-center, bottom-right, right-center*/
            }

            87.5% {
                clip-path: polygon(50% 50%, 50% 0%, 0% 0%, 0% 50%, 0% 100%, 50% 100%, 100% 100%, 100% 50%, 100% 0%, 100% 0%);
                /* center, top-center, top-left, left-center, bottom-left, bottom-center, bottom-right, right-center top-right*/
            }

            100% {
                clip-path: polygon(50% 50%, 50% 0%, 0% 0%, 0% 50%, 0% 100%, 50% 100%, 100% 100%, 100% 50%, 100% 0%, 50% 0%);
                /* center, top-center, top-left, left-center, bottom-left, bottom-center, bottom-right, right-center top-right, top-center*/
            }
        }

        .capital-back {
            font-size: 10px;
        }

        .invest-details-link {
            height: 40px;
            width: 40px;
            line-height: 40px;
            text-align: center;
            border: 1px solid #c3bfbf;
            border-radius: 50px;
            color: #c3bfbf;
        }

        .invest-details-link:hover {
            border-color: #a7a7a7;
            color: #a7a7a7;
        }
    </style>
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";

            let animationCircle = $('.animation-circle');
            animationCircle.css('animation-duration', function() {
                let duration = ($(this).data('duration'));
                return duration;
            });

            $('.manageCapital').on('click', function() {
                let modal = $('#capitalModal');
                modal.find('[name=invest_id]').val($(this).data('id'));
                modal.modal('show');
            });
        })(jQuery);
    </script>
@endpush
