@extends($activeTemplate . 'layouts.master')

@section('content')
    <section class="pb-60 pt-60">
        <div class="container">
            <div class="row justify-content-center mt-2">
                <div class="col-md-12">
                    <div class="text-end mb-3">
                        <a href="{{ route('user.pool.index') }}" class="btn btn--base">
                            @lang('Pool')
                        </a>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="table-responsive--md">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>@lang('Pool')</th>
                                    <th>@lang('Invest Amount')</th>
                                    <th>@lang('Invest Till')</th>
                                    <th>@lang('Return Date')</th>
                                    <th>@lang('Total Return')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($poolInvests as $poolInvest)
                                    <tr>
                                        <td>{{ __($poolInvest->pool->name) }}</td>
                                        <td>{{ showAmount($poolInvest->invest_amount) }} {{ __($general->cur_text) }}</td>
                                        <td>{{ showDateTime($poolInvest->pool->start_date, 'M d, Y h:i A') }}</td>
                                        <td>{{ showDateTime($poolInvest->pool->end_date, 'M d, Y h:i A') }}</td>

                                        <td>
                                            @if ($poolInvest->pool->share_interest)
                                                {{ showAmount($poolInvest->invest_amount * (1 + $poolInvest->pool->interest / 100)) }} {{ __($general->cur_text) }}
                                            @else
                                                @lang('Not return yet!')
                                            @endif
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="100%" class="text-center">{{ __($emptyMessage) }}</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>


                @if ($poolInvests->hasPages())
                    <div class="card-footer">
                        {{ $poolInvests->links() }}
                    </div>
                @endif
            </div>
        </div>
    </section>
@endsection
