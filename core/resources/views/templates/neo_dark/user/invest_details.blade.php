@extends($activeTemplate . 'layouts.master')

@section('content')
    <section class="pb-150 pt-150">
        <div class="container">
            @if ($invest->eligibleCapitalBack())
                <div class="d-flex justify-content-end mb-3">
                    <button class="btn btn--base" data-bs-toggle="modal" data-bs-target="#capitalModal">@lang('Manage Capital')</button>
                </div>
            @endif
            <div class="row gy-3">
                <div class="col-xl-4">
                    <div class="card card-bg">
                        <div class="card-header">
                            <h5 class="title">@lang('Plan Information')</h5>
                        </div>
                        <div class="card-body">
                            <ul class="list-group">
                                @php
                                    $plan = $invest->plan;
                                @endphp
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Plan Name')
                                    <span>{{ __($plan->name) }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Investable Amount')
                                    <span>
                                        @if ($plan->fixed_amount > 0)
                                            {{ $general->cur_sym }}{{ showAmount($plan->fixed_amount) }}
                                        @else
                                            {{ $general->cur_sym }}{{ showAmount($plan->minimum) }} - {{ $general->cur_sym }}{{ showAmount($plan->maximum) }}
                                        @endif
                                    </span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Interest')
                                    <span>{{ showAmount($plan->interest) }}{{ $plan->interest_type == 1 ? '%' : " $general->cur_text" }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Compound Interest')
                                    <span>
                                        @if ($plan->compound_interest)
                                            @lang('Yes')
                                        @else
                                            @lang('No')
                                        @endif
                                    </span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Hold Capital')
                                    <span>
                                        @if ($plan->hold_capital)
                                            @lang('Yes')
                                        @else
                                            @lang('No')
                                        @endif
                                    </span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Repeat Time')
                                    <span>
                                        @if ($plan->repeat_time)
                                            {{ $plan->repeat_time }} @lang('times')
                                        @else
                                            @lang('Lifetime')
                                        @endif
                                    </span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Status')
                                    <span>
                                        @if ($plan->status)
                                            <span class="badge badge--success">@lang('Enable')</span>
                                        @else
                                            <span class="badge badge--warning">@lang('Disable')</span>
                                        @endif
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-md-6">
                    <div class="card card-bg">
                        <div class="card-header">
                            <h5 class="title">@lang('Basic Information')</h5>
                        </div>
                        <div class="card-body">
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Initial Invest')
                                    <span>{{ $general->cur_sym }}{{ showAmount($invest->initial_amount) }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Current Invest')
                                    <span>{{ $general->cur_sym }}{{ showAmount($invest->amount) }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Invested')
                                    <span>{{ showDateTime($invest->created_at) }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Initial Interest')
                                    <span>{{ $general->cur_sym }}{{ showAmount($invest->initial_interest) }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Current Interest')
                                    <span>{{ $general->cur_sym }}{{ showAmount($invest->interest) }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Interest Interval')
                                    <span>@lang('Every ') {{ $invest->time_name }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Status')
                                    <span>
                                        @if ($invest->status == 1)
                                            <span class="badge badge--success">@lang('Running')</span>
                                        @elseif($invest->status == 2)
                                            <span class="badge badge--danger">@lang('Canceled')</span>
                                        @else
                                            <span class="badge badge--info">@lang('Completed')</span>
                                        @endif
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-md-6">
                    <div class="card card-bg">
                        <div class="card-header">
                            <h5>@lang('Other Information')</h5>
                        </div>
                        <div class="card-body">
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Total Payable')
                                    <span>
                                        @if ($invest->period != -1)
                                            {{ $invest->period }} @lang(' times')
                                        @else
                                            @lang('Lifetime')
                                        @endif
                                    </span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Total Paid')
                                    <span>{{ $invest->return_rec_time }} @lang(' times')</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Total Paid Amount')
                                    <span>{{ $general->cur_sym }}{{ showAmount($invest->paid) }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Should Pay')
                                    <span>
                                        @if ($invest->should_pay != -1)
                                            {{ $general->cur_sym }}{{ showAmount($invest->should_pay) }}
                                        @else
                                            **
                                        @endif
                                    </span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Last Paid Time')
                                    <span>{{ showDateTime($invest->last_time) }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Next Pay Time')
                                    <span>{{ showDateTime($invest->next_time) }}</span>
                                </li>

                                <li class="list-group-item d-flex justify-content-between">
                                    @lang('Net Interest')
                                    <span>{{ $general->cur_sym }}{{ showAmount($invest->net_interest) }}</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-lg-12">
                    @if ($invest->compound_times)
                        <h5 class="my-2">@lang('All Interests & Compound Investment')</h5>
                    @else
                        <h5 class="my-2">@lang('All Interests')</h5>
                    @endif
                    <div class="table-responsive--sm neu--table">
                        <table class="table text-white">
                            <thead>
                                <tr>
                                    <th>@lang('TRX')</th>
                                    <th>@lang('Transacted')</th>
                                    <th>@lang('Amount')</th>
                                    <th>@lang('Post Balance')</th>
                                    <th>@lang('Details')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($transactions as $trx)
                                    <tr>
                                        <td><strong>{{ $trx->trx }}</strong></td>
                                        <td>{{ showDateTime($trx->created_at) }}<br>{{ diffForHumans($trx->created_at) }}</td>

                                        <td class="budget">
                                            <span class="fw-bold @if ($trx->trx_type == '+') text--success @else text--danger @endif">
                                                {{ $trx->trx_type }} {{ showAmount($trx->amount) }} {{ $general->cur_text }}
                                            </span>
                                        </td>

                                        <td class="budget">
                                            {{ showAmount($trx->post_balance) }} {{ __($general->cur_text) }}
                                        </td>

                                        <td>{{ __($trx->details) }}</td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td class="text-muted text-center" colspan="100%">{{ __($emptyMessage) }}</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table><!-- table end -->
                        {{ $transactions->links() }}
                    </div>
                </div>
            </div>

        </div>
    </section>

    <div class="modal fade" id="capitalModal">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content modal-content-bg">
                <div class="modal-header">
                    <strong class="modal-title text-white" id="ModalLabel">
                        @lang('Manage Invest Capital')
                    </strong>
                    <button type="button" class="close" data-bs-dismiss="modal">
                        <i class="las la-times"></i>
                    </button>
                </div>
                <form action="{{ route('user.invest.capital.manage') }}" method="post">
                    @csrf
                    <div class="modal-body">
                        <input type="hidden" name="invest_id" value="{{ $invest->id }}">
                        <div class="form-group">
                            <label>@lang('Investment Capital')</label>
                            <select class="form--control" name="capital" required>
                                <option value="reinvest">@lang('Reinvest')</option>
                                <option value="capital_back">@lang('Capital Back')</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--base text--success w-100">@lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
