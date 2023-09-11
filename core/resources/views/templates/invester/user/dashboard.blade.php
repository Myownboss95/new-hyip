@extends($activeTemplate.'layouts.master')
@section('content')

    <div class="dashboard-inner">

        @if ($user->deposit_wallet <= 0 && $user->interest_wallet <= 0)
        <div class="alert border border--danger" role="alert">
            <div class="alert__icon d-flex align-items-center text--danger"><i class="fas fa-exclamation-triangle"></i></div>
            <p class="alert__message">
                <span class="fw-bold">@lang('Empty Balance')</span><br>
                <small><i>@lang('Your balance is empty. Please make') <a href="{{ route('user.deposit.index') }}" class="link-color">@lang('deposit')</a> @lang('for your next investment.')</i></small>
            </p>
        </div>
        @endif

        @if ($user->deposits->where('status',1)->count() == 1 && !$user->invests->count())
        <div class="alert border border--success" role="alert">
            <div class="alert__icon d-flex align-items-center text--success"><i class="fas fa-check"></i></div>
            <p class="alert__message">
                <span class="fw-bold">@lang('First Deposit')</span><br>
                <small><i><span class="fw-bold">@lang('Congratulations!')</span> @lang('You\'ve made your first deposit successfully. Go to') <a href="{{ route('plan') }}" class="link-color">@lang('investment plan')</a> @lang('page and invest now')</i></small>
            </p>
        </div>
        @endif

        @if($pendingWithdrawals)
        <div class="alert border border--primary" role="alert">
            <div class="alert__icon d-flex align-items-center text--primary"><i class="fas fa-spinner"></i></div>
            <p class="alert__message">
                <span class="fw-bold">@lang('Withdrawal Pending')</span><br>
                <small><i>@lang('Total') {{ showAmount($pendingWithdrawals) }} {{ $general->cur_text }} @lang('withdrawal request is pending. Please wait for admin approval. The amount will send to the account which you\'ve provided. See') <a href="{{ route('user.withdraw.history') }}" class="link-color">@lang('withdrawal history')</a></i></small>
            </p>
        </div>
        @endif

        @if($pendingDeposits)
        <div class="alert border border--primary" role="alert">
            <div class="alert__icon d-flex align-items-center text--primary"><i class="fas fa-spinner"></i></div>
            <p class="alert__message">
                <span class="fw-bold">@lang('Deposit Pending')</span><br>
                <small><i>@lang('Total') {{ showAmount($pendingDeposits) }} {{ $general->cur_text }} @lang('deposit request is pending. Please wait for admin approval. See') <a href="{{ route('user.deposit.history') }}" class="link-color">@lang('deposit history')</a></i></small>
            </p>
        </div>
        @endif

        @if(!$user->ts)
        <div class="alert border border--warning" role="alert">
            <div class="alert__icon d-flex align-items-center text--warning"><i class="fas fa-user-lock"></i></div>
            <p class="alert__message">
                <span class="fw-bold">@lang('2FA Authentication')</span><br>
                <small><i>@lang('To keep safe your account, Please enable') <a href="{{ route('user.twofactor') }}" class="link-color">@lang('2FA')</a> @lang('security').</i> @lang('It will make secure your account and balance.')</small>
            </p>
        </div>
        @endif

        @if($isHoliday)
        <div class="alert border border--info" role="alert">
            <div class="alert__icon d-flex align-items-center text--info"><i class="fas fa-toggle-off"></i></div>
            <p class="alert__message">
                <span class="fw-bold">@lang('Holiday')</span><br>
                <small><i>@lang('Today is holiday on this system. You\'ll not get any interest today from this system. Also you\'re unable to make withdrawal request today.') <br> @lang('The next working day is coming after') <span id="counter" class="fw-bold text--primary fs--15px"></span></i></small>
            </p>
        </div>
        @endif

        @if($user->kv == 0)
        <div class="alert border border--info" role="alert">
            <div class="alert__icon d-flex align-items-center text--info"><i class="fas fa-file-signature"></i></div>
            <p class="alert__message">
                <span class="fw-bold">@lang('KYC Verification Required')</span><br>
                <small><i>@lang('Please submit the required KYC information to verify yourself. Otherwise, you couldn\'t make any withdrawal requests to the system.') <a href="{{ route('user.kyc.form') }}" class="link-color">@lang('Click here')</a> @lang('to submit KYC information').</i></small>
            </p>
        </div>
        @elseif($user->kv == 2)
        <div class="alert border border--warning" role="alert">
            <div class="alert__icon d-flex align-items-center text--warning"><i class="fas fa-user-check"></i></div>
            <p class="alert__message">
                <span class="fw-bold">@lang('KYC Verification Pending')</span><br>
                <small><i>@lang('Your submitted KYC information is pending for admin approval. Please wait till that.') <a href="{{ route('user.kyc.data') }}" class="link-color">@lang('Click here')</a> @lang('to see your submitted information')</i></small>
            </p>
        </div>
        @endif

        <div class="row g-3 mt-4">
            <div class="col-lg-4">
                <div class="dashboard-widget">
                    <div class="d-flex justify-content-between">
                        <h5 class="text-secondary">@lang('Successful Deposits')</h5>
                    </div>
                    <h3 class="text--secondary my-4">{{ showAmount($successfulDeposits) }} {{ $general->cur_text }}</h3>
                    <div class="widget-lists">
                        <div class="row">
                            <div class="col-4">
                                <p class="fw-bold">@lang('Submitted')</p>
                                <span>{{ $general->cur_sym }}{{ showAmount($submittedDeposits) }}</span>
                            </div>
                            <div class="col-4">
                                <p class="fw-bold">@lang('Pending')</p>
                                <span>{{ $general->cur_sym }}{{ showAmount($pendingDeposits) }}</span>
                            </div>
                            <div class="col-4">
                                <p class="fw-bold">@lang('Rejected')</p>
                                <span>{{ $general->cur_sym }}{{ showAmount($rejectedDeposits) }}</span>
                            </div>
                        </div>
                        <hr>
                        <p><small><i>@lang('You\'ve requested to deposit') {{ $general->cur_sym }}{{ showAmount($requestedDeposits) }}. @lang('Where') {{ $general->cur_sym }}{{ showAmount($initiatedDeposits) }} @lang('is just initiated but not submitted.')</i></small></p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="dashboard-widget">
                    <div class="d-flex justify-content-between">
                        <h5 class="text-secondary">@lang('Successful Withdrawals')</h5>
                    </div>
                    <h3 class="text--secondary my-4">{{ showAmount($successfulWithdrawals) }} {{ $general->cur_text }}</h3>
                    <div class="widget-lists">
                        <div class="row">
                            <div class="col-4">
                                <p class="fw-bold">@lang('Submitted')</p>
                                <span>{{ $general->cur_sym }}{{ showAmount($submittedWithdrawals) }}</span>
                            </div>
                            <div class="col-4">
                                <p class="fw-bold">@lang('Pending')</p>
                                <span>{{ $general->cur_sym }}{{ showAmount($pendingWithdrawals) }}</span>
                            </div>
                            <div class="col-4">
                                <p class="fw-bold">@lang('Rejected')</p>
                                <span>{{ $general->cur_sym }}{{ showAmount($rejectedWithdrawals) }}</span>
                            </div>
                        </div>
                        <hr>
                        <p><small><i>@lang('You\'ve requested to withdraw') {{ $general->cur_sym }}{{ showAmount($requestedWithdrawals) }}. @lang('Where') {{ $general->cur_sym }}{{ showAmount($initiatedWithdrawals) }} @lang('is just initiated but not submitted.')</i></small></p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="dashboard-widget">
                    <div class="d-flex justify-content-between">
                        <h5 class="text-secondary">@lang('Total Investments')</h5>
                    </div>
                    <h3 class="text--secondary my-4">{{ showAmount($invests) }} {{ $general->cur_text }}</h3>
                    <div class="widget-lists">
                        <div class="row">
                            <div class="col-4">
                                <p class="fw-bold">@lang('Completed')</p>
                                <span>{{ $general->cur_sym }}{{ showAmount($completedInvests) }}</span>
                            </div>
                            <div class="col-4">
                                <p class="fw-bold">@lang('Running')</p>
                                <span>{{ $general->cur_sym }}{{ showAmount($runningInvests) }}</span>
                            </div>
                            <div class="col-4">
                                <p class="fw-bold">@lang('Interests')</p>
                                <span>{{ $general->cur_sym }}{{ showAmount($interests) }}</span>
                            </div>
                        </div>
                        <hr>
                        <p><small><i>@lang('You\'ve invested') {{ $general->cur_sym }}{{ showAmount($depositWalletInvests) }} @lang('from the deposit wallet and') {{ $general->cur_sym }}{{ showAmount($interestWalletInvests) }} @lang('from the interest wallet')</i></small></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mt-4 mb-4">
            <div class="card-body">
                <div class="mb-2">
                    <h5 class="title">@lang('Latest ROI Statistics')</h5>
                    <p> <small><i>@lang('Here is last 30 days statistics of your ROI (Return on Investment)')</i></small></p>
                </div>
                <div id="chart"></div>
            </div>
        </div>
    </div>

@endsection

@push('script')
<script src="{{ asset($activeTemplateTrue.'/js/lib/apexcharts.min.js') }}"></script>

<script>

    // apex-line chart
    var options = {
        chart: {
            height: 350,
            type: "area",
            toolbar: {
                show: false
            },
            dropShadow: {
                enabled: true,
                enabledSeries: [0],
                top: -2,
                left: 0,
                blur: 10,
                opacity: 0.08,
            },
            animations: {
                enabled: true,
                easing: 'linear',
                dynamicAnimation: {
                    speed: 1000
                }
            },
        },
        dataLabels: {
            enabled: false
        },
        series: [
            {
                name: "Price",
                data: [
                    @foreach($chartData as $cData)
                        {{ getAmount($cData->amount) }},
                    @endforeach

                ]
            }
        ],
        fill: {
            type: "gradient",
            colors: ['#4c7de6', '#4c7de6', '#4c7de6'],
            gradient: {
                shadeIntensity: 1,
                opacityFrom: 0.6,
                opacityTo: 0.9,
                stops: [0, 90, 100]
            }
        },
        xaxis: {
            title: "Value",
            categories: [
                @foreach($chartData as $cData)
                "{{ Carbon\Carbon::parse($cData->date)->format('d F') }}",
                @endforeach
            ]
        },
        grid: {
            padding: {
                left: 5,
                right: 5
            },
            xaxis: {
                lines: {
                    show: false
                }
            },
            yaxis: {
                lines: {
                    show: false
                }
            },
        },
    };

    var chart = new ApexCharts(document.querySelector("#chart"), options);

    chart.render();

    @if($isHoliday)
        function createCountDown(elementId, sec) {
            var tms = sec;
            var x = setInterval(function () {
                var distance = tms * 1000;
                var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                var days = `<span>${days}d</span>`;
                var hours = `<span>${hours}h</span>`;
                var minutes = `<span>${minutes}m</span>`;
                var seconds = `<span>${seconds}s</span>`;
                document.getElementById(elementId).innerHTML = days +' '+ hours + " " + minutes + " " + seconds;
                if (distance < 0) {
                    clearInterval(x);
                    document.getElementById(elementId).innerHTML = "COMPLETE";
                }
                tms--;
            }, 1000);
        }

        createCountDown('counter', {{\Carbon\Carbon::parse($nextWorkingDay)->diffInSeconds()}});
    @endif

    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })

</script>
@endpush
