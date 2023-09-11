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
                                    <th>@lang('User')</th>
                                    <th>@lang('Amount')</th>
                                    <th>@lang('Interest')</th>
                                    <th>@lang('Total Return')</th>
                                    <th>@lang('Start Date')</th>
                                    <th>@lang('End Date')</th>
                                    <th>@lang('Status')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($stakingInvests as $stakingInvest)
                                    <tr>
                                        <td>
                                            <span class="fw-bold">{{ $stakingInvest->user->fullname }}</span>
                                            <br>
                                            <span class="small">
                                                <a href="{{ route('admin.users.detail', $stakingInvest->user->id) }}"><span>@</span>{{ $stakingInvest->user->username }}</a>
                                            </span>
                                        </td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($stakingInvest->invest_amount) }}</td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($stakingInvest->interest) }}</td>
                                        <td>{{ $general->cur_sym }}{{ showAmount($stakingInvest->invest_amount + $stakingInvest->interest) }}</td>
                                        <td>{{ showDateTime($stakingInvest->start_date) }}</td>
                                        <td>{{ showDateTime($stakingInvest->end_date) }}</td>
                                        <td>
                                            @if ($stakingInvest->status == 1)
                                                <span class="badge badge--success">@lang('Running')</span>
                                            @else
                                                <span class="badge badge--primary">@lang('Completed')</span>
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
                @if ($stakingInvests->hasPages())
                    <div class="card-footer py-4">
                        {{ paginateLinks($stakingInvests) }}
                    </div>
                @endif
            </div>
        </div>
    </div>
@endsection

@push('breadcrumb-plugins')
    @if(!request()->routeIs('admin.users.deposits') && !request()->routeIs('admin.users.deposits.method'))
        <x-search-form placeholder="Username"/>
    @endif
@endpush

