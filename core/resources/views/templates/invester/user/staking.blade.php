@extends($activeTemplate . 'layouts.master')
@section('content')
    <div class="dashboard-fluid-inner">
        <div class="row">
            <div class="col-xxl-9 col-md-8">
                <div class="card">
                    <div class="card-header d-flex flex-wrap justify-content-between">
                        <h4 class="title">@lang('My Staking')</h4>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table--responsive--md">
                                <thead>
                                    <tr>
                                        <th>@lang('Invest Date')</th>
                                        <th>@lang('Invest Amount')</th>
                                        <th>@lang('Total Return')</th>
                                        <th>@lang('Interest')</th>
                                        <th>@lang('Remaining')</th>
                                        <th>@lang('End At')</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($myStakings as $staking)
                                        <tr>
                                            <td>
                                                <div class="multiline">
                                                    <span class="date d-block">{{ showDateTime($staking->created_at, 'd-m-Y') }}</span>
                                                    <span class="time d-block">{{ showDateTime($staking->created_at, 'h:i A') }}</span>
                                                </div>
                                            </td>
                                            <td>{{ showAmount($staking->invest_amount) }} {{ __($general->cur_text) }}</td>
                                            <td>{{ showAmount($staking->invest_amount + $staking->interest) }} {{ __($general->cur_text) }}</td>
                                            <td>{{ showAmount($staking->interest) }} {{ __($general->cur_text) }}</td>

                                            <td>
                                                @if ($staking->end_at > now())
                                                    @php
                                                        $totalDuration = \Carbon\Carbon::parse($staking->created_at)->diffInSeconds($staking->end_at);
                                                        $remainingDuration = \Carbon\Carbon::parse($staking->end_at)->diffInSeconds(now());
                                                        $completedPercent = (1 - $remainingDuration / $totalDuration) * 100;
                                                    @endphp
                                                    <div class="multiline">
                                                        <span class="remaining-time remainingTime" data-time_remaining="{{ $remainingDuration }}"></span>
                                                        <div class="progress">
                                                            <div class="progress-bar customWidth" data-complete="{{ $completedPercent }}" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                @else
                                                    <span class="badge badge--info">@lang('Completed')</span>
                                                @endif
                                            </td>
                                            <td>
                                                <div class="multiline">
                                                    <span class="date d-block">{{ showDateTime($staking->end_at, 'd-m-Y') }}</span>
                                                    <span class="time d-block">{{ showDateTime($staking->end_at, 'h:i A') }}</span>
                                                </div>
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
                </div>
            </div>
            <div class="col-xxl-3 col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">@lang('Stack Now')</h4>
                        <form action="{{ route('user.staking.save') }}" method="POST">
                            @csrf
                            <div class="form-group">
                                <label class="form-label">@lang('Duration')</label>
                                <select class="form-select form-control form--control" name="duration" required>
                                    <option hidden>@lang('Select One')</option>
                                    @foreach ($stakings as $staking)
                                        <option value="{{ $staking->id }}" data-interest="{{ $staking->interest_percent }}">{{ $staking->days }} @lang('days for ') {{ $staking->interest_percent }}% @lang('interest')</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">@lang('Wallet')</label>
                                <select class="form-select form-control form--control" name="wallet" required>
                                    <option hidden>@lang('Select One')</option>
                                    <option value="deposit_wallet">@lang('Deposit Wallet - ') {{ $general->cur_sym }}{{ showAmount(auth()->user()->deposit_wallet) }}</option>
                                    <option value="interest_wallet">@lang('Interest Wallet - ') {{ $general->cur_sym }}{{ showAmount(auth()->user()->interest_wallet) }}</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">@lang('Amount') ({{ $general->cur_sym . showAmount($general->staking_min_amount) . ' - ' . $general->cur_sym . showAmount($general->staking_max_amount) }})</label>
                                <div class="input-group">
                                    <input type="number" name="amount" class="form-control form--control">
                                </div>
                            </div>
                            <button type="submit" class="btn btn--base w-100 mt-3">@lang('Submit')</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection


@push('script')
    <script>
        (function($) {
            "use strict";

            function formatDuration(seconds) {
                var days = Math.floor(seconds / (3600 * 24));
                var hours = Math.floor((seconds % (3600 * 24)) / 3600);
                var minutes = Math.floor((seconds % 3600) / 60);
                var remainingSeconds = seconds % 60;

                var formattedDuration = '';

                if (days > 0) {
                    formattedDuration += days + 'd ';
                }
                if (hours > 0) {
                    formattedDuration += hours + 'h ';
                }
                if (minutes > 0) {
                    formattedDuration += minutes + 'm ';
                }
                if (remainingSeconds > 0) {
                    formattedDuration += remainingSeconds + 's';
                }

                return formattedDuration.trim();
            }

            $('.remainingTime').each(function(index, element) {
                let remainingTime = $(element).data('time_remaining');
                let $element = $(element);

                setInterval(() => {
                    let formattedDuration = formatDuration(remainingTime);
                    $element.text(formattedDuration);
                    remainingTime--;
                }, 1000);
            });

            $('.customWidth').each(function(index, element) {
                let width = $(this).data('complete');
                $(this).css('width', `${width}%`);
            });

        })(jQuery);
    </script>
@endpush
