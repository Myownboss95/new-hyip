@extends($activeTemplate . 'layouts.master')

@section('content')
    <div class="dashboard-fluid-inner">
        <div class="row">
            <div class="col-lg-12">
                <div class="pool-wrapper">
                    <div class="pool-header">
                        <h4 class="title">{{ __($pageTitle) }}</h4>
                        <a href="{{ route('user.pool.invests') }}" class="btn btn--base">@lang('My Pool')</a>
                    </div>
                    <div class="pool-body">
                        <div class="row justify-content-center">
                            @include($activeTemplate . 'partials.pool', ['pools' => $pools])
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
