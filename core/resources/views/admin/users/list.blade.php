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
                                    <th>@lang('Email-Phone')</th>
                                    <th>@lang('Country')</th>
                                    <th>@lang('Joined At')</th>
                                    <th>@lang('Balance')</th>
                                    <th>@lang('Action')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($users as $user)
                                    <tr>
                                        <td>
                                            <span class="fw-bold">{{ $user->fullname }}</span>
                                            <br>
                                            <span class="small">
                                                <a href="{{ route('admin.users.detail', $user->id) }}"><span>@</span>{{ $user->username }}</a>
                                            </span>
                                        </td>


                                        <td>
                                            {{ $user->email }}<br>{{ $user->mobile }}
                                        </td>
                                        <td>
                                            <span class="fw-bold" title="{{ @$user->address->country }}">{{ $user->country_code }}</span>
                                        </td>



                                        <td>
                                            {{ showDateTime($user->created_at) }} <br> {{ diffForHumans($user->created_at) }}
                                        </td>


                                        <td>
                                            <span class="fw-bold">
                                                @lang('Deposit Wallet') {{ $general->cur_sym }}{{ showAmount($user->deposit_wallet) }}<br>
                                                @lang('Interest Wallet') {{ $general->cur_sym }}{{ showAmount($user->interest_wallet) }}
                                            </span>
                                        </td>

                                        <td>
                                            <div class="button--group">
                                                <a href="{{ route('admin.users.detail', $user->id) }}" class="btn btn-sm btn-outline--primary">
                                                    <i class="las la-desktop"></i> @lang('Details')
                                                </a>
                                                @if (request()->routeIs('admin.users.kyc.pending'))
                                                    <a href="{{ route('admin.users.kyc.details', $user->id) }}" target="_blank" class="btn btn-sm btn-outline--dark">
                                                        <i class="las la-user-check"></i>@lang('KYC Data')
                                                    </a>
                                                @endif
                                            </div>
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
                @if ($users->hasPages())
                    <div class="card-footer py-4">
                        {{ paginateLinks($users) }}
                    </div>
                @endif
            </div>
        </div>


    </div>
@endsection



@push('breadcrumb-plugins')
    <x-search-form placeholder="Username / Email" />
@endpush
