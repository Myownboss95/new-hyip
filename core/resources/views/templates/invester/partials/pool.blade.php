@foreach ($pools as $pool)
    @php
        $investedPercent = ($pool->invested_amount / $pool->amount) * 100;
    @endphp
    <div class="col-xl-4 col-lg-4 col-sm-6">
        <div class="pool-item">
            <h4 class="title">{{ __($pool->name) }}</h4>
            <ul class="list">
                <li class="item">@lang('Total Amount'): {{ $general->cur_sym }}{{ showAmount($pool->amount) }}</li>
                <li class="item">@lang('Invest till'): {{ showDateTime($pool->start_date) }}</li>
                <li class="item">@lang('Return Date'): {{ showDateTime($pool->end_date) }}</li>
            </ul>
            <div class="remaining">
                <h6 class="title">@lang('Invested Amount')</h6>
                <span class="remaining-amount">{{ $general->cur_sym }}{{ showAmount($pool->invested_amount) }}/{{ $general->cur_sym }}{{ showAmount($pool->amount) }}</span>
                <div class="progress">
                    <div class="progress-bar customWidth" data-invested="{{ $investedPercent }}" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
            </div>
            <div class="interest-rate">
                <h5 class="title">{{ __($pool->interest_range) }}</h5>
                <span>@lang('Interest Rate')</span>
            </div>
            <button class="btn btn--base poolInvestNow" data-bs-toggle="modal" data-bs-target="#poolInvestModal" data-pool_id="{{ $pool->id }}" data-pool_name="{{ __($pool->name) }}">@lang('Invest Now')</button>
        </div>
    </div>
@endforeach



<div class="modal fade" id="poolInvestModal">
    <div class="modal-dialog modal-dialog-centered modal-content-bg">
        <div class="modal-content">
            <div class="modal-header">
                @if (auth()->check())
                    <strong class="modal-title" id="ModalLabel">
                        @lang('Confirm to invest on') <span class="planName"></span>
                    </strong>
                @else
                    <strong class="modal-title" id="ModalLabel">
                        @lang('At first sign in your account')
                    </strong>
                @endif
                <button type="button" class="close" data-bs-dismiss="modal">
                    <i class="las la-times"></i>
                </button>
            </div>
            <form action="{{ route('user.pool.invest') }}" method="post">
                @csrf
                <input type="hidden" name="pool_id">
                @if (auth()->check())
                    <div class="modal-body">
                        <div class="form-group">
                            <label>@lang('Pay Via')</label>
                            <select class="form-control form--control form-select" name="wallet_type" required>
                                <option value="">@lang('Select One')</option>
                                @if (auth()->user()->deposit_wallet > 0)
                                    <option value="deposit_wallet">@lang('Deposit Wallet - ' . $general->cur_sym . showAmount(auth()->user()->deposit_wallet))</option>
                                @endif
                                @if (auth()->user()->interest_wallet > 0)
                                    <option value="interest_wallet">@lang('Interest Wallet -' . $general->cur_sym . showAmount(auth()->user()->interest_wallet))</option>
                                @endif
                            </select>
                        </div>

                        <div class="form-group">
                            <label>@lang('Invest Amount')</label>
                            <div class="input-group">
                                <input type="number" step="any" min="0" class="form-control form--control" name="amount" required>
                                <div class="input-group-text">{{ $general->cur_text }}</div>
                            </div>
                            <code class="gateway-info d-none">@lang('Charge'): <span class="charge"></span> {{ $general->cur_text }}. @lang('Total amount'): <span class="total"></span> {{ $general->cur_text }}</code>
                        </div>

                    </div>
                @endif
                <div class="modal-footer">
                    @if (auth()->check())
                        <button type="button" class="btn btn--dark btn-md" data-bs-dismiss="modal">@lang('No')</button>
                        <button type="submit" class="btn btn--base btn-md">@lang('Yes')</button>
                    @else
                        <a href="{{ route('user.login') }}" class="btn btn--base w-100">@lang('At first sign in your account')</a>
                    @endif
                </div>
            </form>
        </div>
    </div>
</div>

@push('script')
    <script>
        (function($) {
            "use strict";
            $('.customWidth').each(function(index, element) {
                let width = $(this).data('invested');
                $(this).css('width', `${width}%`);
            });

            $('.poolInvestNow').on('click', function() {
                $('[name=pool_id]').val($(this).data('pool_id'));
                $('.planName').text($(this).data('pool_name'));
            });
        })(jQuery);
    </script>
@endpush
