@extends($activeTemplate . 'layouts.master')
@section('content')
    <section class="pb-150 pt-150">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="text-end mb-4">
                        <a href="{{ route('user.pool.index') }}" class="btn btn-primary btn-sm">
                            @lang('Pools')
                        </a>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="table-responsive--sm neu--table">
                        <table class="table text-white">
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
                <div class="col-12">
                    {{ $poolInvests->links() }}
                </div>
            </div>
        </div>
    </section>
@endsection
