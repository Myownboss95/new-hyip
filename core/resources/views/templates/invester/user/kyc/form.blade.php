@extends($activeTemplate.'layouts.master')
@section('content')

    <div class="dashboard-inner">
        <div class="mb-4">
            <h3>@lang('KYC Submission')</h3>
            <p>@lang('The system requires you to submit KYC (know your client) information. Your submitted data will be verified by the system\s admin. If all of your information is correct, the admin will approve the KYC data and you\'ll be able to make withdrawal requests') @if($general->b_transfer) @lang('and transfer money to other users') @endif.</p>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="card custom--card">
                    <div class="card-body">
                        <form action="{{route('user.kyc.submit')}}" method="post" enctype="multipart/form-data">
                            @csrf

                            <x-viser-form identifier="act" identifierValue="kyc" />

                            <div class="form-group">
                                <button type="submit" class="btn btn--base w-100">@lang('Submit')</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>


@endsection
@push('style')
    <style>
        .form-group{
            margin-bottom: 12px;
        }
    </style>
@endpush
