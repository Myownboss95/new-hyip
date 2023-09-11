@extends($activeTemplate . 'layouts.master')
@section('content')
    <div class="dashboard-inner">
        <div class="mb-4">
            <p>@lang('Schedule Investment')</p>
            <h3>@lang('My Schedule Investment')</h3>
            <p>@lang('Easily manage your scheduled investments by accessing detailed information such as upcoming investment dates, remaining investment times, and the option to enable or disable each schedule.')</p>
        </div>

        <div class="mt-4">
            <div class="plan-list d-flex flex-wrap flex-xxl-column gap-3 gap-xxl-0">
                @forelse($scheduleInvests as $scheduleInvest)
                    @php
                        $plan = $scheduleInvest->plan;
                        $interest = $plan->interest_type == 1 ? ($scheduleInvest->amount * $plan->interest) / 100 : $plan->interest;
                    @endphp
                    <div class="plan-item-two">
                        <div class="plan-info plan-inner-div">
                            <p class="plan-label">@lang('Plan + Invest Amount')</p>
                            <p class="plan-value date">{{ __($scheduleInvest->plan->name) }} | {{ showAmount($scheduleInvest->amount) }} {{ __($general->cur_text) }}</p>
                        </div>

                        <div class="plan-start plan-inner-div">
                            <p class="plan-label">@lang('Return')</p>
                            <p class="plan-value date">
                                {{ showAmount($interest) }} {{ __($general->cur_text) }} @lang('every') {{ $plan->timeSetting->name }}
                                <br>
                                @lang('for')
                                @if ($plan->lifetime)
                                    @lang('Lifetime')
                                @else
                                    {{ $plan->repeat_time }}
                                    {{ $plan->timeSetting->name }}
                                @endif
                                @if ($plan->capital_back)
                                    + @lang('Capital')
                                @endif
                            </p>
                        </div>
                        <div class="plan-inner-div">
                            <p class="plan-label">@lang('Wallet')</p>
                            <p class="plan-value">{{ __(keyToTitle($scheduleInvest->wallet)) }}</p>
                        </div>
                        <div class="plan-inner-div">
                            <p class="plan-label">@lang('Remaining')</p>
                            <p class="plan-value amount"> {{ $scheduleInvest->rem_schedule_times }} @lang('times')</p>
                        </div>
                        <div class="plan-inner-div">
                            <p class="plan-label">@lang('Next Invest')</p>
                            <p class="plan-value amount">{{ $scheduleInvest->next_invest ? showDateTime($scheduleInvest->next_invest) : '----' }}</p>
                        </div>
                        <div class="plan-inner-div mt-4 d-flex flex-wrap gap-2 justify-content-end">
                            <button class="btn btn--base btn--smd detailsBtn" data-schedule_invest="{{ $scheduleInvest }}" data-interest="{{ showAmount($interest) }}" data-next_invest="{{ $scheduleInvest->next_invest ? showDateTime($scheduleInvest->next_invest) : '-----' }}">
                                @lang('Details')
                            </button>
                            @if ($scheduleInvest->rem_schedule_times)
                                @if ($scheduleInvest->status)
                                    <button class="btn btn--danger btn--smd confirmationBtn" data-question="@lang('Are you sure to disable this schedule invest?')" data-action="{{ route('user.invest.schedule.status', $scheduleInvest->id) }}">
                                        @lang('Disable')
                                    </button>
                                @else
                                    <button class="btn btn--success btn--smd confirmationBtn" data-question="@lang('Are you sure to enable this schedule invest?')" data-action="{{ route('user.invest.schedule.status', $scheduleInvest->id) }}">
                                        @lang('Enable')
                                    </button>
                                @endif
                            @endif
                        </div>
                    </div>
                @empty
                    <div class="accordion-body text-center bg-white p-4">
                        <h4 class="text--muted"><i class="far fa-frown"></i> {{ __($emptyMessage) }}</h4>
                    </div>
                @endforelse
            </div>
            <div class="mt-3">
                {{ $scheduleInvests->links() }}
            </div>
        </div>
    </div>

    <div class="modal fade" id="detailsModal">
        <div class="modal-dialog modal-dialog-centered modal-content-bg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        @lang('Schedule Invest Details')
                    </h5>
                    <button type="button" class="close" data-bs-dismiss="modal">
                        <i class="las la-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <ul class="list-group">
                        <li class="list-group-item d-flex justify-content-between">
                            @lang('Plan Name')
                            <span class="planName"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            @lang('Invest Amount')
                            <span class="investAmount"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            @lang('Interest')
                            <span class="interestAmount"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between compoundInterestBlock">
                            @lang('Compound Interest')
                            <span class="compoundInterest"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            @lang('Schedule Times')
                            <span class="scheduleTimes"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            @lang('Remaining Schedule Times')
                            <span class="remScheduleTimes"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            @lang('Interval')
                            <span class="intervalHours"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            @lang('Next Invest')
                            <span class="nextInvest"></span>
                        </li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger btn-md" data-bs-dismiss="modal">@lang('Close')</button>
                </div>
            </div>
        </div>
    </div>

    <x-confirmation-modal />

@endsection

@push('style')
    <style>
        .plan-item-two .plan-inner-div {
            max-width: 170px;
        }
    </style>
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";

            let curSym = `{{ $general->cur_sym }}`;

            $('.detailsBtn').on('click', function() {
                let modal = $('#detailsModal');
                let data = $(this).data();
                let scheduleInvest = data.schedule_invest;


                modal.find('.planName').text(scheduleInvest.plan.name);
                modal.find('.investAmount').text(curSym + parseFloat(scheduleInvest.amount).toFixed(2));
                modal.find('.interestAmount').text(curSym + parseFloat(data.interest).toFixed(2));
                modal.find('.scheduleTimes').text(scheduleInvest.schedule_times);
                modal.find('.remScheduleTimes').text(scheduleInvest.rem_schedule_times);
                modal.find('.intervalHours').text(`${scheduleInvest.interval_hours} @lang('Hours')`);
                modal.find('.nextInvest').text(data.next_invest);

                if (scheduleInvest.compound_times) {
                    modal.find('.compoundInterest').text(`${scheduleInvest.compound_times} @lang('times')`);
                    $('.compoundInterestBlock').removeClass('d-none');
                } else {
                    $('.compoundInterestBlock').addClass('d-none');
                }

                modal.modal('show');
            });
        })(jQuery);
    </script>
@endpush
