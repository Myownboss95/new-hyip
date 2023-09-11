<!-- meta tags and other links -->
<!DOCTYPE html>
<html lang="{{ config('app.locale') }}">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> {{ $general->siteName(__($pageTitle)) }}</title>
    @include('partials.seo')
    <!-- font  -->
    <link href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@1,400;1,500&family=Maven+Pro:wght@400;500;600&display=swap" rel="stylesheet">


    <link href="{{ asset('assets/global/css/bootstrap.min.css') }}" rel="stylesheet">

    <link href="{{ asset('assets/global/css/all.min.css') }}" rel="stylesheet">

    <link rel="stylesheet" href="{{ asset('assets/global/css/line-awesome.min.css') }}" />

    <link rel="stylesheet" href="{{ asset($activeTemplateTrue . 'css/lib/animate.css') }}">

    <!-- Plugin Link -->
    <link rel="stylesheet" href="{{ asset($activeTemplateTrue . 'css/lib/slick.css') }}">
    <link rel="stylesheet" href="{{ asset($activeTemplateTrue . 'css/lib/magnific-popup.css') }}">
    <link rel="stylesheet" href="{{ asset($activeTemplateTrue . 'css/lib/apexcharts.css') }}">

    <!-- Main css -->
    <link rel="stylesheet" href="{{ asset($activeTemplateTrue . 'css/main.css') }}">

    @stack('style-lib')

    <link rel="stylesheet" href="{{ asset($activeTemplateTrue . 'css/custom.css') }}">

    <link rel="stylesheet" href="{{ asset($activeTemplateTrue . 'css/color.php') }}?color=<?php echo $general->base_color ?>">

    @stack('style')
    <style>
        .pb-120 {
            padding-bottom: clamp(40px, 4vw, 40px);
        }

        .pt-120 {
            padding-top: clamp(40px, 4vw, 40px);
        }

        .container {
            max-width: 1140px;
        }
    </style>

</head>

<body>
    @yield('panel')

    @php
        $cookie = App\Models\Frontend::where('data_keys', 'cookie.data')->first();
        
    @endphp
    @if ($cookie->data_values->status == 1 && !\Cookie::get('gdpr_cookie'))
        <!-- cookies dark version start -->
        <div class="cookies-card text-center hide">
            <div class="cookies-card__icon bg--base">
                <i class="las la-cookie-bite"></i>
            </div>
            <p class="mt-4 cookies-card__content">{{ $cookie->data_values->short_desc }} <a href="{{ route('cookie.policy') }}" class="text-primary" target="_blank">@lang('learn more')</a></p>
            <div class="cookies-card__btn mt-4">
                <a href="javascript:void(0)" class="btn btn--base text-white w-100 policy">@lang('Allow')</a>
            </div>
        </div>
        <!-- cookies dark version end -->
    @endif

    <script src="{{ asset('assets/global/js/jquery-3.6.0.min.js') }}"></script>
    <script src="{{ asset('assets/global/js/bootstrap.bundle.min.js') }}"></script>

    <!-- Pluglin Link -->
    <script src="{{ asset($activeTemplateTrue . 'js/lib/slick.min.js') }}"></script>
    <script src="{{ asset($activeTemplateTrue . 'js/lib/magnific-popup.min.js') }}"></script>
    <script src="{{ asset($activeTemplateTrue . 'js/lib/apexcharts.min.js') }}"></script>

    @stack('script-lib')

    <!-- Main js -->
    <script src="{{ asset($activeTemplateTrue . 'js/main.js') }}"></script>

    @stack('script')

    @include('partials.plugins')

    @include('partials.notify')

    <script>
        $(".langSel").on("change", function() {
            window.location.href = "{{ route('home') }}/change/" + $(this).val();
        });

        Array.from(document.querySelectorAll('table')).forEach(table => {
            let heading = table.querySelectorAll('thead tr th');
            Array.from(table.querySelectorAll('tbody tr')).forEach((row) => {
                Array.from(row.querySelectorAll('td')).forEach((colum, i) => {
                    colum.setAttribute('data-label', heading[i].innerText)
                });
            });
        });

        $.each($('input, select, textarea'), function(i, element) {
            var elementType = $(element);
            if (elementType.attr('type') != 'checkbox') {
                if (element.hasAttribute('required')) {
                    $(element).closest('.form-group').find('label').addClass('required');
                }
            }
        });

        var inputElements = $('[type=text],[type=password],[type=email],[type=number],select,textarea');
        $.each(inputElements, function(index, element) {
            element = $(element);
            element.closest('.form-group').find('label').attr('for', element.attr('name'));
            element.attr('id', element.attr('name'))
        });

        $('.policy').on('click', function() {
            $.get('{{ route('cookie.accept') }}', function(response) {
                $('.cookies-card').addClass('d-none');
            });
        });


        setTimeout(function() {
            $('.cookies-card').removeClass('hide')
        }, 2000);
    </script>
</body>

</html>
