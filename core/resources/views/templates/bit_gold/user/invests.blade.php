@extends($activeTemplate . 'layouts.master')
@section('content')
    <section class="pb-60 pt-60">
        <div class="container">
            <div class="row justify-content-center mt-2">
                <div class="col-md-12">
                    <div class="text-end mb-3">
                        <a href="{{ route('plan') }}" class="btn btn--base">
                            @lang('Investment Plan')
                        </a>
                    </div>
                </div>
                @include($activeTemplate.'partials.invest_history',['invests'=>$invests])
                @if ($invests->hasPages())
                    <div class="card-footer">
                        {{ $invests->links() }}
                    </div>
                @endif
            </div>
        </div>
    </section>
@endsection