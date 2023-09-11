@extends($activeTemplate . 'layouts.master')
@section('content')
    <section class="pb-150 pt-150">

        <div class="container">

            <div class="row gy-4">
                <div class="col-md-5">
                    <div class="card card-bg h-100">
                        <div class="card-body">
                            <div class="d-flex flex-wrap justify-content-between align-items-center">
                                <div>
                                    <p class="mb-2 fw-bold">@lang('Total Invest')</p>
                                    <h4 class="text--base"><sup class="top-0 fw-light me-1">{{ $general->cur_sym }}</sup>{{ showAmount(auth()->user()->invests->sum('amount')) }}</h4>
                                </div>
                                <div>
                                    <p class="mb-2 fw-bold">@lang('Total Profit')</p>
                                    <h4 class="text--base"><sup class="top-0 fw-light me-1">{{ $general->cur_sym }}</sup>{{ showAmount(auth()->user()->transactions()->where('remark', 'interest')->sum('amount')) }}</h4>
                                </div>
                            </div>
                            <div class="d-flex flex-wrap justify-content-between mt-3 mt-sm-4 gap-2">
                                <a href="{{ route('plan') }}" class="btn btn--sm btn--base">@lang('Invest Now') <i class="las la-arrow-right fs--12px ms-1"></i></a>
                                <a href="{{ route('user.withdraw') }}" class="btn btn--sm btn--base">@lang('Withdraw Now') <i class="las la-arrow-right fs--12px ms-1"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <div class="card card-bg h-100">
                        <div class="card-body">
                            @if ($investChart->count())
                                <div class="invest-statistics d-flex flex-wrap justify-content-between align-items-center">
                                    <div class="flex-shrink-0">
                                        @foreach ($investChart as $chart)
                                            <p class="my-2"><i class="fas fa-plane planPoint me-2"></i>{{ showAmount(($chart->investAmount / $investChart->sum('investAmount')) * 100) }}% - {{ __($chart->plan->name) }}</p>
                                        @endforeach
                                    </div>
                                    <div class="invest-statistics__chart">
                                        <canvas height="150" id="chartjs-pie-chart" style="width: 150px;"></canvas>
                                    </div>
                                </div>
                            @else
                                <h3 class="text-center">@lang('No Investment Found Yet')</h3>
                            @endif
                        </div>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center mt-4">
                <div class="col-md-12">
                    <div class="text-end mb-4">
                        <a href="{{ route('user.invest.log') }}" class="btn btn-primary btn-sm">
                            @lang('Investments')
                        </a>
                    </div>
                </div>
                @include($activeTemplate.'partials.invest_history',['invests'=>$invests])
            </div>
        </div>
    </section>
@endsection




@push('script')
    <script src="{{ asset('assets/global/js/chart.min.js') }}"></script>

    <script>
        /* -- Chartjs - Pie Chart -- */
        var pieChartID = document.getElementById("chartjs-pie-chart").getContext('2d');
        var pieChart = new Chart(pieChartID, {
            type: 'pie',
            data: {
                datasets: [{
                    data: [
                        @foreach ($investChart as $chart)
                            {{ $chart->investAmount }},
                        @endforeach
                    ],
                    borderColor: 'transparent',
                    backgroundColor: planColors(),
                    label: 'Dataset 1'
                }],
                labels: [
                    @foreach ($investChart as $chart)
                        '{{ $chart->plan->name }}',
                    @endforeach
                ]
            },
            options: {
                responsive: true,
                legend: {
                    display: false
                }
            }
        });

        var planPoints = $('.planPoint');
        planPoints.each(function(key, planPoint) {
            var planPoint = $(planPoint)
            planPoint.css('color', planColors()[key])
        })

        function planColors() {
            return [
                '#ff7675',
                '#6c5ce7',
                '#ffa62b',
                '#ffeaa7',
                '#D980FA',
                '#fccbcb',
                '#45aaf2',
                '#05dfd7',
                '#FF00F6',
                '#1e90ff',
                '#2ed573',
                '#eccc68',
                '#ff5200',
                '#cd84f1',
                '#7efff5',
                '#7158e2',
                '#fff200',
                '#ff9ff3',
                '#08ffc8',
                '#3742fa',
                '#1089ff',
                '#70FF61',
                '#bf9fee',
                '#574b90'
            ]
        }
    </script>
@endpush
