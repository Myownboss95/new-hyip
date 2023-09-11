@extends($activeTemplate.'layouts.'.$layout)
@section('content')
<section class="pt-150 pb-150">
    <div class="container">
        <div class="row justify-content-center g-4">
            @auth
                <div class="col-md-12">
                    <div class="text-end mb-3">
                        <a href="{{ route('user.invest.statistics') }}" class="btn btn-primary btn-sm">
                            @lang('My Investments')
                        </a>
                    </div>
                </div>
            @endauth
            @include($activeTemplate.'partials.plan', ['plans' => $plans])
        </div>
    </div>
</section>



@guest
    @if($sections->secs != null)
        @foreach(json_decode($sections->secs) as $sec)
            @include($activeTemplate.'sections.'.$sec)
        @endforeach
    @endif
@endguest

@endsection

