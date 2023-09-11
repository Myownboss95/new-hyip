@extends('admin.layouts.app')

@section('panel')
    <div class="row">
        <div class="col-xxl-3 col-sm-6 mb-30">
            <div class="widget-two box--shadow2 has-link b-radius--5 bg--info">
                <a href="{{ route('admin.deposit.rejected') }}" class="item-link"></a>
                <div class="widget-two__content">
                    <h2 class="text-white">{{ $totalInvestCount }}</h2>
                    <p class="text-white">@lang('Total Invest Count')</p>
                </div>
            </div><!-- widget-two end -->
        </div>
        <div class="col-xxl-3 col-sm-6 mb-30">
            <div class="widget-two box--shadow2 b-radius--5 bg--success has-link">
                <a href="{{ route('admin.deposit.successful') }}" class="item-link"></a>
                <div class="widget-two__content">
                    <h2 class="text-white">{{ __($general->cur_sym) }}{{ showAmount($totalInvestAmount) }}</h2>
                    <p class="text-white">@lang('Total Invest')</p>
                </div>
            </div><!-- widget-two end -->
        </div>
        <div class="col-xxl-3 col-sm-6 mb-30">
            <div class="widget-two box--shadow2 b-radius--5 bg--6 has-link">
                <a href="{{ route('admin.deposit.pending') }}" class="item-link"></a>
                <div class="widget-two__content">
                    <h2 class="text-white">{{ __($general->cur_sym) }}{{ showAmount($totalPaid) }}</h2>
                    <p class="text-white">@lang('Total Paid')</p>
                </div>
            </div><!-- widget-two end -->
        </div>
        <div class="col-xxl-3 col-sm-6 mb-30">
            <div class="widget-two box--shadow2 has-link b-radius--5 bg--dark">
                <a href="{{ route('admin.deposit.initiated') }}" class="item-link"></a>
                <div class="widget-two__content">
                    <h2 class="text-white">{{ __($general->cur_sym) }}{{ showAmount($shouldPay) }}</h2>
                    <p class="text-white">@lang('To Pay') (<small>@lang('Without lifetime plan invest')</small>)</p>
                </div>
            </div><!-- widget-two end -->
        </div>

        <div class="col-lg-12">
            <div class="show-filter mb-3 text-end">
                <button type="button" class="btn btn-outline--primary showFilterBtn btn-sm"><i class="las la-filter"></i> @lang('Filter')</button>
            </div>
            <div class="card responsive-filter-card mb-4">
                <div class="card-body">
                    <form action="">
                        <div class="d-flex flex-wrap gap-4">
                            <div class="flex-grow-1">
                                <label>@lang('Plan/Username')</label>
                                <input type="text" name="search" value="{{ request()->search }}" class="form-control">
                            </div>
                            <div class="flex-grow-1">
                                <label>@lang('Return Type')</label>
                                <select name="type" class="form-control">
                                    <option value="">@lang('All')</option>
                                    <option value="repeat" @selected(request()->type == 'repeat')>@lang('Repeat')</option>
                                    <option value="lifetime" @selected(request()->type == 'lifetime')>@lang('Lifetime')</option>
                                </select>
                            </div>

                            <div class="flex-grow-1">
                                <label>@lang('Status')</label>
                                <select name="status" class="form-control">
                                    <option value="">@lang('All')</option>
                                    <option value="1" @selected(request()->status == '1')>@lang('Running')</option>
                                    <option value="0" @selected(request()->status == '0')>@lang('Closed')</option>
                                </select>
                            </div>

                            <div class="flex-grow-1">
                                <label>@lang('Date')</label>
                                <input name="date" type="text" data-range="true" data-multiple-dates-separator=" - " data-language="en" class="datepicker-here form-control" data-position='bottom right' placeholder="@lang('Start date - End date')" autocomplete="off" value="{{ request()->date }}">
                            </div>
                            <div class="flex-grow-1 align-self-end">
                                <button class="btn btn--primary w-100 h-45"><i class="fas fa-filter"></i> @lang('Filter')</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="card b-radius--10 ">
                <div class="card-body p-0">
                    <div class="table-responsive--sm table-responsive">
                        <table class="table table--light style--two">
                            <thead>
                                <tr>
                                    <th>@lang('User')</th>
                                    <th>@lang('Plan Name')</th>
                                    <th>@lang('Amount')</th>
                                    <th>@lang('Interest')</th>
                                    <th>@lang('To Pay')</th>
                                    <th>@lang('Paid')</th>
                                    <th>@lang('Status')</th>
                                    <th>@lang('Action')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($invests as $invest)
                                    <tr>
                                        <td>
                                            <span class="fw-bold">{{ $invest->user->fullname }}</span>
                                            <br>
                                            <span class="small"> <a href="{{ appendQuery('search', $invest->user->username) }}"><span>@</span>{{ $invest->user->username }}</a> </span>
                                        </td>

                                        <td>{{ __($invest->plan->name) }}</td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($invest->amount) }}</td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($invest->interest) }}</td>
                                        <td>{{ $invest->should_pay != -1 ? $general->cur_sym . showAmount($invest->should_pay) : '**' }}</td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($invest->paid) }}</td>
                                        <td>
                                            @if ($invest->status == 1)
                                                <span class="badge badge--success">@lang('Running')</span>
                                            @elseif($invest->status == 2)
                                                <span class="badge badge--danger">@lang('Canceled')</span>
                                            @else
                                                <span class="badge badge--dark">@lang('Closed')</span>
                                            @endif
                                        </td>
                                        <td>
                                            <div class="button--group">
                                                <a href="{{ route('admin.report.invest.details', $invest->id) }}" class="btn btn-outline--primary btn-sm"><i class="las la-desktop"></i>@lang('Details')</a>
                                                <button class="btn btn-outline--danger btn-sm cancelBtn" data-invest_id="{{ $invest->id }}" @disabled($invest->status != 1)><i class="las la-times"></i>@lang('Cancel')</button>
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td class="text-muted text-center" colspan="100%">{{ __($emptyMessage) }}</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table><!-- table end -->
                    </div>
                </div>
                @if ($invests->hasPages())
                    <div class="card-footer py-4">
                        {{ paginateLinks($invests) }}
                    </div>
                @endif
            </div><!-- card end -->
        </div>
    </div>

    <div class="modal fade" id="cancelModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">@lang('Cancel Investment')</h4>
                    <button type="button" class="close" data-bs-dismiss="modal"><span><i class="las la-times"></i></span></button>
                </div>
                <form method="post" action="{{ route('admin.plan.invest.cancel') }}">
                    @csrf
                    <div class="modal-body">
                        <input type="hidden" name="invest_id">
                        <div class="form-group">
                            <label>@lang('Action') </label>
                            <select name="action" class="form-control" required>
                                <option hidden>@lang('Select One')</option>
                                <option value="1">@lang('Capital Back & Interest remains in the user balance')</option>
                                <option value="2">@lang('Capital Back & Interest is deducted from the user balance')</option>
                                <option value="3">@lang('No Capital Back & Interest remains in the user balance')</option>
                                <option value="4">@lang('No Capital Back & Interest is deducted from the user balance')</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--primary w-100 h-45"><i class="fa fa-send"></i> @lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection

@push('style-lib')
    <link rel="stylesheet" href="{{ asset('assets/admin/css/vendor/datepicker.min.css') }}">
@endpush

@push('script-lib')
    <script src="{{ asset('assets/admin/js/vendor/datepicker.min.js') }}"></script>
    <script src="{{ asset('assets/admin/js/vendor/datepicker.en.js') }}"></script>
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";

            $('.cancelBtn').on('click', function() {
                let modal = $('#cancelModal');
                $('[name=invest_id]').val($(this).data('invest_id'));
                modal.modal('show');
            });

            if (!$('.datepicker-here').val()) {
                $('.datepicker-here').datepicker();
            }
        })(jQuery)
    </script>
@endpush
