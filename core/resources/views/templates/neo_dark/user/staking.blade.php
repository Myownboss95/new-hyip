@extends($activeTemplate . 'layouts.master')
@section('content')
    <script>
        "use strict"

        function createCountDown(elementId, sec) {
            var tms = sec;
            var x = setInterval(function() {
                var distance = tms * 1000;
                var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                document.getElementById(elementId).innerHTML = days + "d: " + hours + "h " + minutes + "m " + seconds + "s ";
                if (distance < 0) {
                    clearInterval(x);
                    document.getElementById(elementId).innerHTML = "COMPLETE";
                }
                tms--;
            }, 1000);
        }
    </script>
    <section class="pb-150 pt-150">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="text-end mb-4">
                        <button data-bs-toggle="modal" data-bs-target="#stakingModal" class="btn btn--base">
                            @lang('Staking Now')
                        </button>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="table-responsive--sm neu--table">
                        <table class="table text-white">
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
                                        <td>{{ showDateTime($staking->created_at) }}</td>
                                        <td>{{ showAmount($staking->invest_amount) }} {{ __($general->cur_text) }}</td>
                                        <td>{{ showAmount($staking->invest_amount + $staking->interest) }} {{ __($general->cur_text) }}</td>
                                        <td>{{ showAmount($staking->interest) }} {{ __($general->cur_text) }}</td>

                                        <td scope="row" class="font-weight-bold">
                                            @if ($staking->end_at > now())
                                                <p id="counter{{ $staking->id }}" class="demo countdown timess2 "></p>
                                                <div class="progress">
                                                    <div class="progress-bar progress-bar-striped bg-success" role="progressbar" style="width: {{ diffDatePercent($staking->created_at, $staking->end_at) }}%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">
                                                    </div>
                                                </div>
                                            @else
                                                <span class="badge badge--info">@lang('Completed')</span>
                                            @endif
                                        </td>
                                        <td>{{ showDateTime($staking->end_at) }}</td>
                                    </tr>
                                    @if (\Carbon\Carbon::parse($staking->end_at) > now())
                                        <script>
                                            createCountDown('counter<?php echo $staking->id; ?>', {{ \Carbon\Carbon::parse($staking->end_at)->diffInSeconds() }});
                                        </script>
                                    @endif
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
                    {{ $myStakings->links() }}
                </div>
            </div>
        </div>
    </section>


    <div class="modal fade" id="stakingModal">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content modal-content-bg">
                <div class="modal-header">
                    <strong class="modal-title text-white" id="ModalLabel">
                        @lang('Staking Now')
                    </strong>
                    <button type="button" class="close" data-bs-dismiss="modal">
                        <i class="las la-times"></i>
                    </button>
                </div>
                <form action="{{ route('user.staking.save') }}" method="post">
                    @csrf
                    @if (auth()->check())
                        <div class="modal-body">
                            <div class="form-group">
                                <label>@lang('Duration')</label>
                                <select class="form--control" name="duration" required>
                                    <option value="">@lang('Select One')</option>
                                    @foreach ($stakings as $staking)
                                        <option value="{{ $staking->id }}" data-interest="{{ $staking->interest_percent }}">{{ $staking->days }} @lang('Days - Interest') {{ $staking->interest_percent }}%</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="form-group">
                                <label>@lang('Wallet')</label>
                                <select class="form--control" name="wallet" required>
                                    <option hidden>@lang('Select One')</option>
                                    <option value="deposit_wallet">@lang('Deposit Wallet - ') {{ $general->cur_sym }}{{ showAmount(auth()->user()->deposit_wallet) }}</option>
                                    <option value="interest_wallet">@lang('Interest Wallet - ') {{ $general->cur_sym }}{{ showAmount(auth()->user()->interest_wallet) }}</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>@lang('Amount')({{ $general->cur_sym.showAmount($general->staking_min_amount).' - '.$general->cur_sym.showAmount($general->staking_max_amount) }})</label>
                                <div class="input-group">
                                    <input type="number" step="any" min="0" class="form-control" name="amount" required>
                                    <div class="input-group-text">{{ $general->cur_text }}</div>
                                </div>
                            </div>
                        </div>
                    @endif
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--base text--success w-100">@lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
