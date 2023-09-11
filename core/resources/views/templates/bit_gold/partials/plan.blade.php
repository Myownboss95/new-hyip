@foreach ($plans as $k => $data)
    <div class="col-xl-3 col-lg-4 col-md-6">
        <div class="package-card text-center bg_img" data-background="{{ asset($activeTemplateTrue . '/images/bg/bg-4.png') }}">
            <h4 class="package-card__title base--color mb-2">{{ __($data->name) }}</h4>

            <ul class="package-card__features mt-4">
                <li>@lang('Return')
                    {{ showAmount($data->interest) }}{{ $data->interest_type == 1 ? '%' : ' ' . __($general->cur_text) }}
                </li>

                <li>
                    @lang('Every') {{ __($data->timeSetting->name) }}
                </li>
                <li>@lang('For') @if ($data->lifetime == 0)
                        {{ __($data->repeat_time) }} {{ __($data->timeSetting->name) }}
                    @else
                        @lang('Lifetime')
                    @endif
                </li>
                <li>
                    @if ($data->lifetime == 0)
                        @lang('Total')
                        {{ __($data->interest * $data->repeat_time) }}{{ $data->interest_type == 1 ? '%' : ' ' . __($general->cur_text) }}
                        @if ($data->capital_back == 1)
                            +
                            <span class="badge badge--success">@lang('Capital')</span>
                        @endif
                    @else
                        @lang('Lifetime Earning')
                    @endif
                </li>
                @if ($data->compound_interest)
                    <li>
                        @lang('Compound interest available')
                    </li>
                @endif
                @if ($data->hold_capital)
                    <li>
                        @lang('Hold capital & reinvest')
                    </li>
                @endif
            </ul>
            <div class="package-card__range mt-5 base--color">
                @if ($data->fixed_amount == 0)
                    {{ __($general->cur_sym) }}{{ showAmount($data->minimum) }} -
                    {{ __($general->cur_sym) }}{{ showAmount($data->maximum) }}
                @else
                    {{ __($general->cur_sym) }}{{ showAmount($data->fixed_amount) }}
                @endif
            </div>
            <a href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#investModal" data-plan="{{ $data }}" class="btn--base btn-md mt-4 investModal">@lang('Invest Now')</a>
        </div><!-- package-card end -->
    </div>
@endforeach

<div class="modal fade" id="investModal">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-content-bg">
        <div class="modal-content">
            <div class="modal-header">
                @if (auth()->check())
                    <strong class="modal-title text-white" id="ModalLabel">
                        @lang('Confirm to invest on') <span class="planName"></span>
                    </strong>
                @else
                    <strong class="modal-title text-white" id="ModalLabel">
                        @lang('At first sign in your account')
                    </strong>
                @endif
                <button type="button" class="close" data-bs-dismiss="modal">
                    <i class="las la-times"></i>
                </button>
            </div>
            <form action="{{ route('user.invest.submit') }}" method="post">
                @csrf
                <input type="hidden" name="plan_id">
                @if (auth()->check())
                    <div class="modal-body">
                        <div class="form-group">
                            <h6 class="text-center investAmountRange"></h6>
                            <p class="text-center mt-1 interestDetails"></p>
                            <p class="text-center interestValidity"></p>
                            <p class="text-center calculatedInterest"></p>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>@lang('Pay Via')</label>
                                    <select class="form-control form-select" name="wallet_type" required>
                                        <option value="">@lang('Select One')</option>
                                        @if (auth()->user()->deposit_wallet > 0)
                                            <option value="deposit_wallet">@lang('Deposit Wallet - ' . $general->cur_sym . showAmount(auth()->user()->deposit_wallet))</option>
                                        @endif
                                        @if (auth()->user()->interest_wallet > 0)
                                            <option value="interest_wallet">@lang('Interest Wallet -' . $general->cur_sym . showAmount(auth()->user()->interest_wallet))</option>
                                        @endif
                                        @foreach ($gatewayCurrency as $data)
                                            <option value="{{ $data->id }}" @selected(old('wallet_type') == $data->method_code) data-gateway="{{ $data }}">{{ $data->name }}</option>
                                        @endforeach
                                    </select>
                                    <code class="gateway-info rate-info d-none">@lang('Rate'): 1 {{ $general->cur_text }} = <span class="rate"></span> <span class="method_currency"></span></code>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>@lang('Invest Amount')</label>
                                    <div class="input-group">
                                        <input type="number" step="any" min="0" class="form-control" name="amount" required>
                                        <div class="input-group-text bg--base">{{ $general->cur_text }}</div>
                                    </div>
                                    <code class="gateway-info d-none">@lang('Charge'): <span class="charge"></span> {{ $general->cur_text }}. @lang('Total amount'): <span class="total"></span> {{ $general->cur_text }}</code>
                                </div>
                            </div>
                            <div class="col-md-6 compoundInterest">
                                <div class="form-group">
                                    <label>@lang('Compound Interest') (@lang('optional'))</label>
                                    <div class="input-group">
                                        <input type="number" min="0" class="form-control" name="compound_interest">
                                        <div class="input-group-text bg--base">@lang('Times')</div>
                                    </div>
                                    <small class="fst-italic text--info"><i class="las la-info-circle"></i> @lang('Your interest will add to the investment capital amount for a specific time that you\'re entering.')</small>
                                </div>
                            </div>
                            @if ($general->schedule_invest)
                                <div class="col-md-6 investTime">
                                    <div class="form-group">
                                        <label>@lang('Auto Schedule Invest')</label>
                                        <select class="form-control form-select" name="invest_time" required>
                                            <option value="invest_now">@lang('Invest Now')</option>
                                            <option value="schedule">@lang('Schedule')</option>
                                        </select>
                                        <small class="fst-italic text--info"><i class="las la-info-circle"></i> @lang('You can set your investment as a scheduler or invest instant.')</small>
                                    </div>
                                </div>
                            @endif
                        </div>

                        @if ($general->schedule_invest)
                            <div class="row schedule">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="required">@lang('Schedule For')</label>
                                        <div class="input-group">
                                            <input type="number" min="0" class="form-control" name="schedule_times">
                                            <span class="input-group-text">@lang('Times')</span>
                                        </div>
                                        <small class="fst-italic text--info"><i class="las la-info-circle"></i> @lang('Set how many times you want to invest.')</small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="required">@lang('After')</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" name="hours" min="0">
                                            <span class="input-group-text">@lang('Hours')</span>
                                        </div>
                                        <small class="fst-italic text--info"><i class="las la-info-circle"></i> @lang('Set a frequency at which you prefer to make investments.')</small>
                                    </div>
                                </div>
                            </div>
                        @endif

                    </div>
                @endif
                <div class="modal-footer">
                    @if (auth()->check())
                        <button type="button" class="btn btn-danger btn-md" data-bs-dismiss="modal">@lang('No')</button>
                        <button type="submit" class="btn btn--base btn-md">@lang('Yes')</button>
                    @else
                        <a href="{{ route('user.login') }}" class="btn--base btn-md w-100 text-center">@lang('At first sign in your account')</a>
                    @endif
                </div>
            </form>
        </div>
    </div>
</div>


@push('script')
    <script>
        (function($) {
            "use strict"
            var symbol = '{{ $general->cur_sym }}';
            var currency = '{{ $general->cur_text }}';
            var plan;

            $('.investModal').click(function() {
                $('.gateway-info').addClass('d-none');
                var modal = $('#investModal');
                plan = $(this).data('plan');

                modal.find('.planName').text(plan.name)
                modal.find('[name=plan_id]').val(plan.id);
                let fixedAmount = parseFloat(plan.fixed_amount).toFixed(2);
                let minimumAmount = parseFloat(plan.minimum).toFixed(2);
                let maximumAmount = parseFloat(plan.maximum).toFixed(2);
                let interestAmount = parseFloat(plan.interest);

                if (plan.fixed_amount > 0) {
                    modal.find('.investAmountRange').text(`Invest: ${symbol}${fixedAmount}`);
                    modal.find('[name=amount]').val(fixedAmount);
                    modal.find('[name=amount]').attr('readonly', true);
                } else {
                    modal.find('.investAmountRange').text(`Invest: ${symbol}${minimumAmount} - ${symbol}${maximumAmount}`);
                    modal.find('[name=amount]').val('');
                    modal.find('[name=amount]').removeAttr('readonly');
                }

                if (plan.interest_type == '1') {
                    modal.find('.interestDetails').html(`<strong> Interest: ${interestAmount}% </strong>`);
                } else {
                    modal.find('.interestDetails').html(`<strong> Interest: ${interestAmount} ${currency}  </strong>`);
                }

                if (plan.lifetime == '0') {
                    modal.find('.interestValidity').html(`<strong>  Per ${plan.time_setting.name} for  ${plan.repeat_time} times</strong>`);
                } else {
                    modal.find('.interestValidity').html(`<strong>  Per ${plan.time_setting.time} hours for life time </strong>`);
                }

                if (plan.compound_interest == '1') {
                    $('.compoundInterest').show();
                    $('.investTime').removeClass('col-md-12');
                } else {
                    $('.compoundInterest').hide();
                    $('.investTime').addClass('col-md-12');
                }
                calculateInterest();
            });

            $('[name=amount]').on('input', function() {
                $('[name=wallet_type]').trigger('change');
                calculateInterest();
            })

            $('[name=wallet_type]').change(function() {
                var amount = $('[name=amount]').val();
                if ($(this).val() && $(this).val() != 'deposit_wallet' && $(this).val() != 'interest_wallet' && amount) {
                    var resource = $('select[name=wallet_type] option:selected').data('gateway');
                    var fixed_charge = parseFloat(resource.fixed_charge);
                    var percent_charge = parseFloat(resource.percent_charge);
                    var charge = parseFloat(fixed_charge + (amount * percent_charge / 100)).toFixed(2);
                    $('.charge').text(charge);
                    $('.rate').text(parseFloat(resource.rate));
                    $('.gateway-info').removeClass('d-none');
                    if (resource.currency == '{{ $general->cur_text }}') {
                        $('.rate-info').addClass('d-none');
                    } else {
                        $('.rate-info').removeClass('d-none');
                    }
                    $('.method_currency').text(resource.currency);
                    $('.total').text(parseFloat(charge) + parseFloat(amount));
                } else {
                    $('.gateway-info').addClass('d-none');
                }
            });

            $('[name=invest_time]').on('change', function() {
                let investTime = $(this).find(':selected').val();
                if (investTime == 'invest_now') {
                    $('.schedule').hide();
                } else {
                    $('.schedule').show();
                }
            }).change();

            $('[name=schedule_times]').on('input', function() {
                let text = $(this).val() == 1 ? `@lang('After')` : `@lang('Every')`;
                $('[name=hours]').closest('.form-group').find('label').text(text);
            });

            $('[name=compound_interest]').on('input', function() {
                calculateInterest();
            })


            function calculateInterest() {
                let interest = parseFloat(plan.interest);
                let interestType = plan.interest_type; //1: percent, 0: fixed
                let repeatTime = plan.repeat_time;
                let capitalBack = plan.capital_back;
                let investAmount = $('[name=amount]').val() * 1;
                let compoundInterest = $('[name=compound_interest]').val() ?? 0;
                let calculatedInterest = 0;
                let baseInterest = 0;

                if (repeatTime == 0 || investAmount == 0) {
                    $('.calculatedInterest').hide();
                    return false;
                } else {
                    $('.calculatedInterest').show();
                }

                let totalInterest = interest * repeatTime;

                if (interestType == '1') {
                    if (compoundInterest > 0) {
                        let remainingRepeatTime = repeatTime - compoundInterest;
                        let interestRatio = 1 + interest / 100;
                        let compoundCapital = investAmount * Math.pow(interestRatio, compoundInterest);
                        totalInterest = (compoundCapital * interest / 100) * remainingRepeatTime;
                    } else {
                        totalInterest = interest * investAmount / 100 * repeatTime;
                    }
                }

                totalInterest = capitalBack ? totalInterest : totalInterest - investAmount;
                $('.calculatedInterest').text(`@lang('Total Profit') ` + symbol + totalInterest.toFixed(2));
            }

            @if (!$general->schedule_invest)
                $('.modal-dialog').removeClass('modal-lg');
                $('.modal-dialog').find('.col-md-6').addClass('col-md-12');
            @endif

        })(jQuery);
    </script>
@endpush
