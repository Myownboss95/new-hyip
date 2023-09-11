@extends($activeTemplate . 'layouts.master')
@section('content')
    <div class="cmn-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card custom--card">
                        <div class="card-header">
                            <h5 class="text-center"> <i class="las la-wallet"></i> @lang('NMI')</h5>
                        </div>
                        <div class="card-body">
                            <form role="form" id="payment-form" method="{{ $data->method }}" action="{{ $data->url }}">
                                @csrf
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="form-label">@lang('Card Number')</label>
                                        <div class="input-group">
                                            <input type="tel" class="form-control form--control"
                                                name="billing-cc-number" autocomplete="off"
                                                value="{{ old('billing-cc-number') }}" required autofocus />
                                            <span class="input-group-text"><i class="fa fa-credit-card"></i></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mt-4">
                                    <div class="col-md-6">
                                        <label class="form-label">@lang('Expiration Date')</label>
                                        <input type="tel" class="form-control form--control" name="billing-cc-exp"
                                            value="{{ old('billing-cc-exp') }}" placeholder="e.g. MM/YY" autocomplete="off"
                                            required />
                                    </div>
                                    <div class="col-md-6 ">
                                        <label class="form-label">@lang('CVC Code')</label>
                                        <input type="tel" class="form-control form--control" name="billing-cc-cvv"
                                            value="{{ old('billing-cc-cvv') }}" autocomplete="off" required />
                                    </div>
                                </div>
                                <br>
                                <button class="btn btn--base w-100" type="submit"> @lang('Submit')</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
