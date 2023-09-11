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
    <section class="pb-60 pt-60">
        <div class="container">
            <div class="row justify-content-center mt-2">
                <div class="col-md-12">
                    <div class="text-end mb-3">
                        <button data-bs-toggle="modal" data-bs-target="#stakingModal" class="btn btn--base">
                            @lang('Staking Now')
                        </button>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="table-responsive--md">
                        <table class="table">
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
                @if ($myStakings->hasPages())
                    <div class="card-footer">
                        {{ $myStakings->links() }}
                    </div>
                @endif
            </div>
        </div>
    </section>

    <div class="modal fade" id="stakingModal">
        <div class="modal-dialog modal-dialog-centered modal-content-bg">
            <div class="modal-content">
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
                    <div class="modal-body">
                        <div class="form-group">
                            <label>@lang('Duration')</label>
                            <select name="duration" class="form-control" required>
                                <option hidden>@lang('Select One')</option>
                                @foreach ($stakings as $staking)
                                    <option value="{{ $staking->id }}" data-interest="{{ $staking->interest_percent }}">{{ $staking->days }} @lang('Days - Interest') {{ $staking->interest_percent }}%</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="form-group">
                            <label>@lang('Wallet')</label>
                            <select name="wallet" class="form-control" required>
                                <option hidden>@lang('Select One')</option>
                                <option value="deposit_wallet">@lang('Deposit Wallet - ') {{ $general->cur_sym }}{{ showAmount(auth()->user()->deposit_wallet) }}</option>
                                <option value="interest_wallet">@lang('Interest Wallet - ') {{ $general->cur_sym }}{{ showAmount(auth()->user()->interest_wallet) }}</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>@lang('Amount') ({{ $general->cur_sym.showAmount($general->staking_min_amount).' - '.$general->cur_sym.showAmount($general->staking_max_amount) }})</label>
                            <div class="input-group">
                                <input type="number" name="amount" class="form-control" min="0" step="any" autocomplete="off" required>
                                <span class="input-group-text">{{ __($general->cur_text) }}</span>
                            </div>
                        </div>
                        <span class="text--danger totalReturn">@lang('Total Return: ')<span class="returnAmount"></span></span>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--base btn-md w-100">@lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection


@push('script')
    <script>
        (function($) {
            "use strict";
            $('.stakingNow').on('click', function() {
                let modal = $('#stakingModal');
                modal.find('[name=invest_id]').val($(this).data('id'));
                modal.modal('show');
            });

            let interest = 0,
                amount = 0,
                totalReturn = 0;

            $('[name=duration]').on('change', function() {
                interest = $(this).find(':selected').data('interest');
                calculateInterest();
            }).change();

            $('[name=amount]').on('input', function() {
                amount = $(this).val() * 1;
                calculateInterest();
            });

            function calculateInterest() {
                totalReturn =  amount * interest / 100 +  amount;
                if (totalReturn) {
                    $('.totalReturn').show();
                    $('.returnAmount').text(totalReturn.toFixed(2) + ` {{ __($general->cur_text) }}`);
                } else {
                    $('.totalReturn').hide();
                }
            }

        })(jQuery);
    </script>
@endpush
