@extends('admin.layouts.app')
@section('panel')
    <div class="row">
        <div class="col-lg-12">
            <div class="card b-radius--10 ">
                <div class="card-body p-0">
                    <div class="table-responsive--md  table-responsive">
                        <table class="table table--light style--two">
                            <thead>
                                <tr>
                                    <th>@lang('S.N.')</th>
                                    <th>@lang('Days')</th>
                                    <th>@lang('Interest')</th>
                                    <th>@lang('Status')</th>
                                    <th>@lang('Action')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($stakings as $staking)
                                    <tr>
                                        <td>{{ $stakings->firstItem() + $loop->index }}</td>
                                        <td>{{ $staking->days }} @lang('days')</td>
                                        <td>{{ showAmount($staking->interest_percent) }}%</td>
                                        <td>@php echo $staking->statusBadge; @endphp</td>
                                        <td>
                                            <div class="button--group">
                                                <button data-id="{{ $staking->id }}" data-duration="{{ $staking->days }}" data-interest_amount="{{ getAmount($staking->interest_percent) }}" class="btn btn-outline--primary editBtn btn-sm"><i class="las la-pen"></i>@lang('Edit')</button>
                                                @if ($staking->status)
                                                    <button class="btn btn-sm btn-outline--danger confirmationBtn" data-question="@lang('Are you sure to disable this staking?')" data-action="{{ route('admin.staking.status', $staking->id) }}"><i class="las la-eye-slash"></i>@lang('Disable')</button>
                                                @else
                                                    <button class="btn btn-sm btn-outline--success confirmationBtn" data-question="@lang('Are you sure to enable this staking?')" data-action="{{ route('admin.staking.status', $staking->id) }}"><i class="las la-eye"></i>@lang('Enable')</button>
                                                @endif
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
                @if ($stakings->hasPages())
                    <div class="card-footer py-4">
                        {{ paginateLinks($stakings) }}
                    </div>
                @endif
            </div>
        </div>
    </div>

    <div class="modal fade" id="stakingModal">
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
                            <label>@lang('Duration') </label>
                            <div class="input-group">
                                <input type="number" class="form-control" name="duration" min="1" required>
                                <span class="input-group-text">@lang('Days')</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>@lang('Interest Amount')</label>
                            <div class="input-group">
                                <input type="number" class="form-control" name="interest_amount" min="0" step="any" required>
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

@push('breadcrumb-plugins')
    <button class="btn btn-outline--primary btn-sm addBtn"><i class="las la-plus"></i> @lang('Add New')</button>
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";
            let modal = $('#stakingModal');
            let action = `{{ route('admin.staking.save') }}`;

            $('.addBtn').on('click', function() {
                modal.find('.modal-title').text(`@lang('Add New Staking')`);
                modal.find('[name=duration]').val('');
                modal.find('[name=interest_amount]').val('');
                modal.find('form').attr('action', action);
                modal.modal('show');
            });

            $('.editBtn').on('click', function() {
                let staking = $(this).data();
                modal.find('.modal-title').text(`@lang('Update Staking')`);
                modal.find('[name=duration]').val(staking.duration);
                modal.find('[name=interest_amount]').val(staking.interest_amount);
                modal.find('form').attr('action', `${action}/${staking.id}`);
                modal.modal('show');
            });

        })(jQuery);
    </script>
@endpush
