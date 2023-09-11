@foreach ($pools as $pool)
    <div class="col-lg-4 col-md-6">
        <div class="pricing-item">
            <div class="pricing-item__header">
                <span class="package__price text-shadow">{{ __($pool->name) }}</span>
                <div class="package__offer text-shadow">
                    {{ __($general->cur_sym) }}{{ showAmount($pool->amount) }}
                </div>
            </div>
            <div class="pricing-item__content">
                <ul class="package__feature-list">
                    <li class="text-shadow">@lang('Invest Till') {{ showDateTime($pool->start_date) }}</li>
                    <li class="text-shadow">@lang('Return Date') {{ showDateTime($pool->end_date) }}</li>
                    <li class="text-shadow">@lang('Interest Range') {{ __($pool->interest_range) }}</li>

                    <li class="text-shadow">
                        <div class="remaining mb-2">
                            <h6 class="title">@lang('Invested Amount')</h6>
                            <span class="remaining-amount">{{ $general->cur_sym }}{{ showAmount($pool->invested_amount) }}/{{ $general->cur_sym }}{{ showAmount($pool->amount) }}</span>
                            <div class="progress">
                                <div class="progress-bar customWidth" data-invested="{{ getAmount(($pool->invested_amount / $pool->amount) * 100) }}" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </li>
                </ul>

                <a href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#poolInvestModal" data-pool_id="{{ $pool->id }}" data-pool_name="{{ __($pool->name) }}" class="btn btn-primary btn-small mt-30 poolInvestNow">@lang('Invest now')</a>

            </div>
        </div><!-- pricing-item end -->
    </div>
@endforeach

<div class="modal fade" id="poolInvestModal">
    <div class="modal-dialog modal-dialog-centered ">
        <div class="modal-content modal-content-bg">
            <div class="modal-header">
                @if (auth()->check())
                    <strong class="modal-title text-white" id="ModalLabel">
                        @lang('Confirm to invest on') <span class="planName"></span>
                    </strong>
                @else
                    <strong class="modal-title text-white" id="ModalLabel">
                        @lang('At first sign in your account')
                    </strong>
                @endif
                <button type="button" class="close" data-bs-dismiss="modal">
                    <i class="las la-times"></i>
                </button>
            </div>
            <form action="{{ route('user.pool.invest') }}" method="post">
                @csrf
                @if (auth()->check())
                    <input type="hidden" name="pool_id">
                    <div class="modal-body">

                        <div class="form-group">
                            <label>@lang('Pay Via')</label>
                            <select class="form--control" name="wallet_type" required>
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
                                <input type="number" step="any" min="0" class="form-control" name="amount" required>
                                <div class="input-group-text">{{ $general->cur_text }}</div>
                            </div>
                        </div>
                    </div>
                @endif
                <div class="modal-footer">
                    @if (auth()->check())
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">@lang('No')</button>
                        <button type="submit" class="btn btn--base text--success">@lang('Yes')</button>
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
            "use strict"

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
