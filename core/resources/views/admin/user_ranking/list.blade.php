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
                                    <th>@lang('Icon')</th>
                                    <th>@lang('Level')</th>
                                    <th>@lang('Name')</th>
                                    <th>@lang('Minimum Invest')</th>
                                    <th>@lang('Bonus')</th>
                                    <th>@lang('Status')</th>
                                    <th>@lang('Action')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($userRankings as $userRanking)
                                    <tr>
                                        <td><img src="{{ getImage(getFilePath('userRanking') . '/' . $userRanking->icon, getFileSize('userRanking')) }}" class="ranking-image" alt=""></td>
                                        <td>{{ __($userRanking->level) }}</td>
                                        <td>{{ __($userRanking->name) }}</td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($userRanking->minimum_invest) }}</td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($userRanking->bonus) }}</td>
                                        <td>
                                            @php
                                                echo $userRanking->statusBadge;
                                            @endphp
                                        </td>
                                        <td>
                                            <button class="btn btn-sm btn-outline--primary editBtn me-1" data-icon="{{ getImage(getFilePath('userRanking') . '/' . $userRanking->icon, getFileSize('userRanking')) }}" data-ranking="{{ $userRanking }}"
                                                data-action="{{ route('admin.plan.update', $userRanking->id) }}"><i class="las la-pen"></i>@lang('Edit')</button>
                                            @if ($userRanking->status)
                                                <button class="btn btn-sm btn-outline--danger confirmationBtn" data-question="@lang('Are you sure to disable this ranking?')" data-action="{{ route('admin.ranking.status', $userRanking->id) }}"><i class="las la-eye-slash"></i>@lang('Disable')</button>
                                            @else
                                                <button class="btn btn-sm btn-outline--success confirmationBtn" data-question="@lang('Are you sure to enable this ranking?')" data-action="{{ route('admin.ranking.status', $userRanking->id) }}"><i class="las la-eye"></i>@lang('Enable')</button>
                                            @endif
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

    <div class="modal fade" id="rankingModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">@lang('Add New User Ranking')</h5>
                    <button type="button" class="close" data-bs-dismiss="modal">
                        <i class="las la-times"></i>
                    </button>
                </div>
                <form action="{{ route('admin.ranking.store') }}" method="post" enctype="multipart/form-data">
                    @csrf
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xl-4 col-lg-5">
                                <div class="form-group">
                                    <label class="icon">@lang('Icon')</label>
                                    <div class="image-upload">
                                        <div class="thumb">
                                            <div class="avatar-preview">
                                                <div class="profilePicPreview">
                                                    <button type="button" class="remove-image"><i class="fa fa-times"></i></button>
                                                </div>
                                            </div>
                                            <div class="avatar-edit">
                                                <input type="file" class="profilePicUpload d-none" name="icon" id="profilePicUpload1" accept=".png, .jpg, .jpeg" required>
                                                <label for="profilePicUpload1" class="bg--success mt-3">@lang('Upload Image')</label>
                                                <small class="mt-2">@lang('Supported files'): <b>@lang('png'), @lang('jpeg'), @lang('jpg').</b> @lang('Image will be resized into ') {{ getFileSize('userRanking') }} @lang('px')</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-8 col-lg-7">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>@lang('Level')</label>
                                            <input type="number" class="form-control" name="level" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>@lang('Name')</label>
                                            <input type="text" class="form-control" name="name" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>@lang('Minimum Invest')</label>
                                    <div class="input-group">
                                        <input type="number" step="any" name="minimum_invest" min="0" class="form-control" required>
                                        <span class="input-group-text">{{ $general->cur_text }}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>@lang('Team Minimum Invest')</label>
                                    <div class="input-group">
                                        <input type="number" step="any" name="team_minimum_invest" min="0" class="form-control" required>
                                        <span class="input-group-text">{{ $general->cur_text }}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>@lang('Minimum Direct Referral')</label>
                                        <input type="number" name="min_referral" min="0" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>@lang('Bonus')</label>
                                    <div class="input-group">
                                        <input type="number" step="any" name="bonus" min="0" class="form-control" required>
                                        <span class="input-group-text">{{ $general->cur_text }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--primary w-100 h-45">@lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <x-confirmation-modal />
@endsection

@push('breadcrumb-plugins')
    <button class="btn btn-outline--primary btn-sm addBtn" data-icon="{{ getImage(null, getFileSize('userRanking')) }}"><i class="las la-plus"></i> @lang('Add New')</button>
@endpush

@push('style')
    <style>
        .image-upload .thumb .profilePicPreview {
            height: 230px;
        }
        .ranking-image{
            width: 60px;
        }
    </style>
@endpush

@push('script')
    <script>
        (function($) {
            "use strict"
            let modal = $('#rankingModal');
            let action = `{{ route('admin.ranking.store') }}`;

            $('.addBtn').on('click', function() {
                modal.find('form').attr('action', action);
                modal.modal('show');
                modal.find('form')[0].reset();
                modal.find('.profilePicPreview').css('backgroundImage', `url(${$(this).data('icon')})`);
            });

            $('.editBtn').on('click', function() {
                let ranking = $(this).data('ranking');
                modal.find('[name=level]').val(ranking.level);
                modal.find('[name=name]').val(ranking.name);
                modal.find('[name=minimum_invest]').val(parseFloat(ranking.minimum_invest).toFixed(2));
                modal.find('[name=team_minimum_invest]').val(parseFloat(ranking.min_referral_invest).toFixed(2));
                modal.find('[name=min_referral]').val(ranking.min_referral);
                modal.find('[name=bonus]').val(parseFloat(ranking.bonus).toFixed(2));
                modal.find('[name=description]').val(ranking.description);
                modal.find('.profilePicPreview').css('backgroundImage', `url(${$(this).data('icon')})`);
                modal.find('.icon').removeClass('required');
                modal.find('[name=icon]').removeAttr('required');

                modal.find('form').attr('action', `${action}/${ranking.id}`);
                modal.modal('show');
            });

        })(jQuery);
    </script>
@endpush
