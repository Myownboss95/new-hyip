@extends('admin.layouts.app')
@section('panel')
    <div class="row">
        <div class="col-lg-12">
            @if($general->system_customized)
                <div class="alert alert-warning p-3" role="alert">@lang('The system already customized. You can\'t update the project.')</div>
            @endif
            <div class="card b-radius--10">
                <div class="card-body">
                    @forelse($updates as $update)
                    <div class="update-card">
                        <h5>@lang('Version') {{ $update->version }} | @lang('Uploaded'): {{ $update->created_at->format('Y-m-d') }}</h5>
                        <hr>
                        <ul>
                            @foreach($update->update_log as $log)
                            <li>{{ __($log) }}</li>
                            @endforeach
                        </ul>
                    </div>
                    @empty
                    <h1 class="text-center">@lang('No update patch uploaded yet.')</h1>
                    @endforelse
                </div>
            </div><!-- card end -->
        </div>
    </div>


    <!-- Modal -->
    <div class="modal fade" id="uploadUpdate">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">@lang('Upload Update Patch')</h5>
                    <button type="button" class="close" data-bs-dismiss="modal">
                        <span><i class="las la-times"></i></span>
                    </button>
                </div>
                <form action="{{ route('admin.system.update.upload') }}" enctype="multipart/form-data" method="post">
                    @csrf
                    <div class="modal-body">
                        <div class="alert alert-warning p-3" role="alert">@lang('If you\'ve made any customization on this project, please don\'t upload the updated file. It may raise issues.')</div>
                        <div class="form-group">
                            <label>@lang('Purchase Code')</label>
                            <input type="text" name="purchase_code" value="{{ env('PURCHASECODE') }}" class="form-control" readonly required>
                        </div>
                        <div class="form-group">
                            <label>@lang('Envato Username')</label>
                            <input type="text" name="envato_username" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>@lang('Files')</label>
                            <input type="file" name="file" class="form-control" accept=".zip" required>
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

@push('style')
    <style>
        .update-card:last-child{
            margin-bottom: 0;
        }
        .update-card{
            margin-bottom: 40px
        }
        .update-card li {
            font-size: 17px;
            margin: 5px 0px;
        }
    </style>
@endpush
@if(!$general->system_customized)
    @push('breadcrumb-plugins')
        @if (!extension_loaded('zip'))
            <span class="text--danger mx-3"><span class="fw-bold text--danger">@lang('PHP-zip')</span> @lang('Extension is required')</span>
            <button type="button" disabled class="btn btn-sm btn-outline--primary"><i class="las la-upload"></i>@lang('Upload')</button>
        @else
            <button type="button" class="btn btn-sm btn-outline--primary" data-bs-toggle="modal" data-bs-target="#uploadUpdate"><i class="las la-upload"></i>@lang('Upload')</button>
        @endif
    @endpush
@endif