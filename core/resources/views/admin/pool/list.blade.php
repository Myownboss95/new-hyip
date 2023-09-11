@extends('admin.layouts.app')
@section('panel')
    <div class="row">
        <div class="col-lg-12">
            <div class="card table-dropdown-solved b-radius--10 ">
                <div class="card-body p-0">
                    <div class="table-responsive--md table-responsive">
                        <table class="table table--light style--two">
                            <thead>
                                <tr>
                                    <th>@lang('Name')</th>
                                    <th>@lang('Amount')</th>
                                    <th>@lang('Invested Amount')</th>
                                    <th>@lang('End Date')</th>
                                    <th>@lang('Share Interest')</th>
                                    <th>@lang('Status')</th>
                                    <th>@lang('Action')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($pools as $pool)
                                    <tr>
                                        <td>{{ __($pool->name) }}</td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($pool->amount) }}</td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($pool->invested_amount) }}</td>
                                        <td>{{ showDateTime($pool->end_date) }}</td>
                                        <td>
                                            @if ($pool->share_interest)
                                                <span class="badge badge--success">@lang('Yes')</span>
                                            @else
                                                <span class="badge badge--warning">@lang('No')</span>
                                            @endif
                                        </td>
                                        <td>@php echo $pool->statusBadge; @endphp</td>
                                        <td>
                                            <div class="button--group">
                                                <button data-id="{{ $pool->id }}" data-pool="{{ $pool }}" data-amount="{{ getAmount($pool->amount) }}" class="btn btn-outline--primary editBtn btn-sm"><i class="las la-pen"></i>@lang('Edit')</button>

                                                <button type="button" class="btn btn-sm btn-outline--info" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="las la-ellipsis-v"></i>@lang('More')
                                                </button>

                                                <div class="dropdown-menu more-dropdown">

                                                    @if ($pool->status)
                                                        <button class="dropdown-item confirmationBtn" data-question="@lang('Are you sure to disable this pool?')" data-action="{{ route('admin.pool.status', $pool->id) }}"><i class="las la-eye-slash"></i> @lang('Disable')</button>
                                                    @else
                                                        <button class="dropdown-item confirmationBtn" data-question="@lang('Are you sure to enable this pool?')" data-action="{{ route('admin.pool.status', $pool->id) }}"><i class="las la-eye"></i> @lang('Enable')</button>
                                                    @endif
                                                    @if (!$pool->share_interest)
                                                        <button class="dropdown-item dispatchBtn" data-pool_id="{{ $pool->id }}" data-interest_range="{{ $pool->interest_range }}">
                                                            <i class="las la-trophy"></i> @lang('Dispatch')
                                                        </button>
                                                    @endif
                                                </div>
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
                @if ($pools->hasPages())
                    <div class="card-footer py-4">
                        {{ paginateLinks($pools) }}
                    </div>
                @endif
            </div>
        </div>
    </div>

    <div class="modal fade" id="poolModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"></h4>
                    <button type="button" class="close" data-bs-dismiss="modal"><span><i class="las la-times"></i></span></button>
                </div>
                <form method="post">
                    @csrf
                    <div class="modal-body">
                        <div class="form-group">
                            <label>@lang('Name') </label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="form-group">
                            <label>@lang('Amount')</label>
                            <div class="input-group">
                                <input type="number" class="form-control" name="amount" step="any" min="0" required>
                                <span class="input-group-text">{{ __($general->cur_text) }}</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>@lang('Interest Range') </label>
                            <input type="text" class="form-control" name="interest_range" required>
                        </div>
                        <div class="form-group">
                            <label>@lang('Start Date') </label>
                            <input type="datetime-local" class="form-control" name="start_date" required>
                        </div>
                        <div class="form-group">
                            <label>@lang('End Date') </label>
                            <input type="datetime-local" class="form-control" name="end_date" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--primary w-100 h-45"><i class="fa fa-send"></i> @lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="dispatchModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">@lang('Dispatch Pool')</h4>
                    <button type="button" class="close" data-bs-dismiss="modal"><span><i class="las la-times"></i></span></button>
                </div>
                <form action="{{ route('admin.pool.dispatch') }}" method="post">
                    @csrf
                    <div class="modal-body">
                        <input type="hidden" name="pool_id">
                        <div class="form-group">
                            <label>@lang('Interest Rate') (<small>@lang('Interest Range'): <span class="interestRange"></span></small>)</label>
                            <div class="input-group">
                                <input type="number" class="form-control" name="amount" step="any" min="0" required>
                                <span class="input-group-text">%</span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--primary w-100 h-45"><i class="fa fa-send"></i> @lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <x-confirmation-modal />
@endsection

@push('style')
    <style>
        .table-dropdown-solved.card {
            background-color: transparent;
            box-shadow: none;
        }

        .table-dropdown-solved .table-responsive--sm.table-responsive {
            background-color: transparent;
            overflow: unset !important;
        }

        .table-dropdown-solved .table {
            background-color: #fff;
            border-radius: 5px;
        }

        .table-dropdown-solved .table-responsive {
            min-height: 200px;
        }

        .more-dropdown .dropdown-item {
            font-size: 14px;
            border-bottom: 1px solid #dddddd61;
            padding: 5px 15px;
        }

        .more-dropdown .dropdown-item:last-child {
            border-bottom: 0;
        }
    </style>
@endpush

@push('breadcrumb-plugins')
    <button class="btn btn-outline--primary btn-sm addBtn"><i class="las la-plus"></i> @lang('Add New')</button>
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";

            let modal = $('#poolModal');
            let action = `{{ route('admin.pool.save') }}`;

            $('.addBtn').on('click', function() {
                modal.find('.modal-title').text(`@lang('Add New Pool')`);
                modal.find('form').attr('action', action);
                modal.modal('show');
            });

            $('.editBtn').on('click', function() {
                let data = $(this).data();
                let pool = data.pool;
                modal.find('.modal-title').text(`@lang('Update Update')`);
                modal.find('[name=name]').val(pool.name);
                modal.find('[name=amount]').val($(this).data('amount'));
                modal.find('[name=interest_range]').val(pool.interest_range);
                modal.find('[name=start_date]').val(pool.start_date);
                modal.find('[name=end_date]').val(pool.end_date);
                modal.find('form').attr('action', `${action}/${pool.id}`);
                modal.modal('show');
            });


            $('.dispatchBtn').on('click', function() {
                let modal = $('#dispatchModal');
                $('.interestRange').text($(this).data('interest_range'));
                modal.find('[name=pool_id]').val($(this).data('pool_id'));
                modal.find('[name=amount]').val('');
                modal.modal('show');
            });

        })(jQuery);
    </script>
@endpush
