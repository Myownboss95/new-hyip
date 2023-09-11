@extends('admin.layouts.app')

@section('panel')
    <div class="row">
        <div class="col-lg-12">
            <div class="card b-radius--10 ">
                <div class="card-body p-0">
                    <div class="table-responsive--sm table-responsive">
                        <table class="table table--light custom-data-table">
                            <thead>
                                <tr>
                                    <th>@lang('Name')</th>
                                    <th>@lang('Schedule')</th>
                                    <th>@lang('Next Run')</th>
                                    <th>@lang('Last Run')</th>
                                    <th>@lang('Is Running')</th>
                                    <th>@lang('Type')</th>
                                    <th>@lang('Actions')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($crons as $cron)
                                    @php
                                        $dateTime = now()->parse($cron->next_run);
                                        $formattedDateTime = $dateTime->format('Y-m-d\TH:i');
                                    @endphp

                                    <tr>
                                        <td>
                                            {{ __($cron->name) }} @if ($cron->logs->where('error', '!=', null)->count())
                                                <i class="fas fa-exclamation-triangle text--danger"></i>
                                            @endif <br>
                                            <code>{{ __($cron->alias) }}</code>
                                        </td>
                                        <td>{{ __($cron->schedule->name) }}</td>
                                        <td>
                                            @if ($cron->next_run)
                                                {{ __($cron->next_run) }}
                                                <br> {{ diffForHumans($cron->next_run) }}
                                            @else
                                                --
                                            @endif
                                        </td>
                                        <td>
                                            @if ($cron->last_run)
                                                {{ __($cron->last_run) }}
                                                <br> {{ diffForHumans($cron->last_run) }}
                                            @else
                                                --
                                            @endif
                                        </td>
                                        <td>
                                            @if ($cron->is_running)
                                                <span class="badge badge--success">@lang('Running')</span>
                                            @else
                                                <span class="badge badge--dark">@lang('Pause')</span>
                                            @endif
                                        </td>
                                        <td>
                                            @if ($cron->is_default)
                                                <span class="badge badge--success">@lang('Default')</span>
                                            @else
                                                <span class="badge badge--primary">@lang('Customizable')</span>
                                            @endif
                                        </td>
                                        <td>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline--primary" id="actionButton" data-bs-toggle="dropdown">
                                                    <i class="las la-ellipsis-v"></i>
                                                    @lang('Action')
                                                </button>
                                                <div class="dropdown-menu p-0">
                                                    <a href="{{ route('cron') }}?alias={{ $cron->alias }}" class="dropdown-item"><i class="las la-check-circle"></i> @lang('Run Now')</a>
                                                    @if ($cron->is_running)
                                                        <a href="{{ route('admin.cron.schedule.pause', $cron->id) }}" class="dropdown-item"><i class="las la-pause"></i> @lang('Pause')</a>
                                                    @else
                                                        <a href="{{ route('admin.cron.schedule.pause', $cron->id) }}" class="dropdown-item"><i class="las la-play"></i> @lang('Play')</a>
                                                    @endif
                                                    <a href="" data-id="{{ $cron->id }}" data-name="{{ $cron->name }}" data-url="{{ $cron->url }}" data-next_run="{{ $formattedDateTime }}" data-cron_schedule_id="{{ $cron->cron_schedule_id }}" data-default="{{ $cron->is_default }}"
                                                        class="dropdown-item updateCron"><i class="las la-pen"></i> @lang('Edit')</a>
                                                    <a href="{{ route('admin.cron.schedule.logs', $cron->id) }}" class="dropdown-item"><i class="las la-history"></i> @lang('Logs')</a>
                                                    @if (!$cron->is_default)
                                                        <a href="javascript:void(0)" data-action="{{ route('admin.cron.delete', $cron->id) }}" data-question="@lang('Are you sure to delete this cron?')" class="dropdown-item confirmationBtn"><i class="las la-trash"></i> @lang('Delete')</a>
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
            </div><!-- card end -->
        </div>
    </div>

    <x-confirmation-modal />

    <div class="modal fade" id="addCron" tabindex="-1" role="dialog" a aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">@lang('Add Cron Job')</h4>
                    <button type="button" class="close" data-bs-dismiss="modal"><i class="las la-times"></i></button>
                </div>
                <form class="form-horizontal resetForm" method="post" action="{{ route('admin.cron.store') }}">
                    @csrf

                    <div class="modal-body">
                        <div class="form-group">
                            <label>@lang('Name')</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="form-group">
                            <label>@lang('Next Run')</label>
                            <input type="datetime-local" name="next_run" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>@lang('Schedule')</label>
                            <select name="cron_schedule_id" class="form-control" required>
                                @foreach ($schedules as $schedule)
                                    <option value="{{ $schedule->id }}">{{ $schedule->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="form-group">
                            <label>@lang('Url')</label>
                            <input type="text" name="url" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--primary h-45 w-100">@lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <div class="modal fade" id="updateCron" tabindex="-1" role="dialog" a aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">@lang('Edit Cron Job')</h4>
                    <button type="button" class="close" data-bs-dismiss="modal"><i class="las la-times"></i></button>
                </div>
                <form class="form-horizontal resetForm" method="post" action="{{ route('admin.cron.update') }}">
                    @csrf
                    <input type="hidden" name="id">
                    <div class="modal-body">
                        <div class="form-group">
                            <label>@lang('Name')</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="form-group">
                            <label>@lang('Next Run')</label>
                            <input type="datetime-local" name="next_run" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>@lang('Schedule')</label>
                            <select name="cron_schedule_id" class="form-control" required>
                                @foreach ($schedules as $schedule)
                                    <option value="{{ $schedule->id }}">{{ $schedule->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="form-group urlGroup">
                            <label>@lang('Url')</label>
                            <input type="text" name="url" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--primary h-45 w-100">@lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection

@push('breadcrumb-plugins')
    <button type="btn" class="btn btn-outline--primary addCron"><i class="las la-plus"></i> @lang('Add')</button>
    <a href="{{ route('admin.cron.schedule') }}" class="btn btn-outline--primary"><i class="las la-clock"></i> @lang('Cron Schedule')</a>
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";

            $('.addCron').on('click', function() {
                let modal = $('#addCron');
                $('.resetForm').trigger('reset');
                modal.modal('show');
            });

            $('.updateCron').on('click', function(e) {
                e.preventDefault();
                var modal = $('#updateCron');
                let id = $(this).data('id');
                let name = $(this).data('name');
                let next_run = $(this).data('next_run');
                let cron_schedule_id = $(this).data('cron_schedule_id');
                let isDefault = $(this).data('default');
                if (isDefault) {
                    modal.find('[name=url]').attr('required', false);
                    $('.urlGroup').hide();
                } else {
                    modal.find('[name=url]').parent().find('label').addClass('required');
                    modal.find('[name=url]').attr('required', true);
                    modal.find('[name=url]').val($(this).data('url'));
                    $('.urlGroup').show();
                }
                modal.find('input[name=id]').val(id);
                modal.find('input[name=name]').val(name);
                modal.find('input[name=next_run]').val(next_run);
                modal.find('select[name=cron_schedule_id]').val(cron_schedule_id);
                modal.modal('show');
            });

        })(jQuery);
    </script>
@endpush
