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
<div class="col-md-12">
    <div class="table-responsive--sm neu--table">
        <table class="table text-white">
            <thead>
                <tr>
                    <th scope="col">@lang('Plan')</th>
                    <th scope="col">@lang('Return')</th>
                    <th scope="col">@lang('Received')</th>
                    <th scope="col">@lang('Next payment')</th>
                    <th scope="col">@lang('Action')</th>
                </tr>
            </thead>
            <tbody>
                @forelse($invests as $invest)
                    <tr>
                        <td>{{ __($invest->plan->name) }} <br> {{ showAmount($invest->amount) }} {{ __($general->cur_text) }} </td>
                        <td>
                            {{ showAmount($invest->interest) }} {{ __($general->cur_text) }} @lang('every') {{ $invest->time_name }}
                            <br>
                            @lang('for')
                            @if ($invest->period == '-1')
                                @lang('Lifetime')
                            @else
                                {{ $invest->period }}
                                {{ $invest->time_name }}
                            @endif
                            @if ($invest->capital_status == '1')
                                + @lang('Capital')
                            @endif
                        </td>
                        <td>
                            @if ($invest->compound_times)
                                {{ $invest->return_rec_time }} @lang('times') | {{ showAmount($invest->paid) }} {{ $general->cur_text }}
                            @else
                                {{ $invest->return_rec_time }}x{{ showAmount($invest->interest) }} = {{ showAmount($invest->paid) }} {{ __($general->cur_text) }}
                            @endif
                        </td>

                        <td scope="row" class="font-weight-bold">
                            @if ($invest->status == 1)
                                <p id="counter{{ $invest->id }}" class="demo countdown timess2 "></p>

                                @php
                                    if ($invest->last_time) {
                                        $start = $invest->last_time;
                                    } else {
                                        $start = $invest->created_at;
                                    }
                                @endphp
                                <div class="progress">
                                    <div class="progress-bar progress-bar-striped bg-success" role="progressbar" style="width: {{ diffDatePercent($start, $invest->next_time) }}%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">
                                    </div>
                                </div>
                            @elseif($invest->status == 2)
                                <span class="badge badge--danger">@lang('Canceled')</span>
                            @else
                                <span class="badge badge--success">@lang('Completed')</span>
                            @endif
                        </td>
                        <td>
                            <a href="{{ route('user.invest.details', encrypt($invest->id)) }}" class="btn btn-sm btn--base w-auto btn-sm text-white">
                                <i class="fa fa-desktop"></i>
                            </a>
                            @if ($invest->eligibleCapitalBack())
                                <button class="btn btn-sm btn--base w-auto btn-sm text-white manageCapital" data-id="{{ $invest->id }}">
                                    <i class="fas fa-hand-holding-usd"></i>
                                </button>
                            @endif
                        </td>

                        @php
                            $nextTime = \Carbon\Carbon::parse($invest->next_time);
                        @endphp
                    </tr>
                    @if ($nextTime > now())
                        <script>
                            createCountDown('counter<?php echo $invest->id; ?>', {{ $nextTime->diffInSeconds() }});
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

<div class="modal fade" id="capitalModal">
    <div class="modal-dialog modal-dialog-centered ">
        <div class="modal-content modal-content-bg">
            <div class="modal-header">
                <strong class="modal-title text-white" id="ModalLabel">
                    @lang('Manage Invest Capital')
                </strong>
                <button type="button" class="close" data-bs-dismiss="modal">
                    <i class="las la-times"></i>
                </button>
            </div>
            <form action="{{ route('user.invest.capital.manage') }}" method="post">
                @csrf
                <div class="modal-body">
                    <input type="hidden" name="invest_id">
                    <div class="form-group">
                        <label>@lang('Investment Capital')</label>
                        <select class="form--control" name="capital" required>
                            <option value="reinvest">@lang('Reinvest')</option>
                            <option value="capital_back">@lang('Capital Back')</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn--base text--success w-100">@lang('Submit')</button>
                </div>
            </form>
        </div>
    </div>
</div>

@push('script')
    <script>
        (function($) {
            "use strict";
            $('.manageCapital').on('click', function() {
                let modal = $('#capitalModal');
                modal.find('[name=invest_id]').val($(this).data('id'));
                modal.modal('show');
            });
        })(jQuery);
    </script>
@endpush
