@props([
    'link' => '',
    'title' => '',
    'value' => '',
    'icon' => '',
    'bg' => 'white',
    'color' => 'primary',
    'icon_style' => 'outline',
    'overlay_icon' => 1,
])

<div class="widget-two box--shadow2 b-radius--5 bg--{{ $bg }}">
    @if ((bool) $overlay_icon)
        <i class="{{ $icon }} overlay-icon text--{{ $color }}"></i>
    @endif

    <div class="widget-two__icon b-radius--5  @if ($icon_style == 'outline') border border--{{ $color }} text--{{ $color }} @else bg--{{ $color }} @endif ">
        <i class="{{ $icon }}"></i>
    </div>

    <div class="widget-two__content">
        <h3>{{ $value }}</h3>
        <p>{{ __($title) }}</p>
    </div>

    @if ($link)
        <a href="{{ $link }}" class="widget-two__btn btn btn-outline--{{ $color }}">@lang('View All')</a>
    @endif
</div>