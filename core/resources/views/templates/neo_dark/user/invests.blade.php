@extends($activeTemplate . 'layouts.master')
@section('content')
    <section class="pb-150 pt-150">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="text-end mb-4">
                        <a href="{{ route('plan') }}" class="btn btn-primary btn-sm">
                            @lang('Investment Plan')
                        </a>
                    </div>
                </div>
                @include($activeTemplate.'partials.invest_history',['invests'=>$invests])
                <div class="col-12">
                    {{ $invests->links() }}
                </div>
            </div>
        </div>
    </section>
@endsection