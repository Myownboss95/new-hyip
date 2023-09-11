@props([
    'style' => 1,
    'link' => null,
    'title' => null,
    'value' => null,
    'icon' => null,
    'bg' => null,
    'color' => null,
    'icon_color' => null,
    'icon_style' => 'outline',
    'overlay_icon' => 1,
])

@php
    $iconColor = $icon_color ?? $color;
    $widget = 'x-widget-' . $style;
@endphp

@if ($style == 1)
    <x-widget-1 :link=$link :title=$title :value=$value :icon=$icon :bg=$bg :color=$color :icon_color=$icon_color />
@endif

@if ($style == 2)
    <x-widget-2 :link=$link :title=$title :value=$value :icon=$icon :bg=$bg :color=$color :icon_color=$icon_color :icon_style=$icon_style :overlay_icon=$overlay_icon />
@endif

@if ($style == 3)
    <x-widget-3 :link=$link :title=$title :value=$value :icon=$icon :bg=$bg :color=$color />
@endif
@if ($style == 4)
    <x-widget-4 :link=$link :title=$title :value=$value :bg=$bg :color=$color />
@endif
@if ($style == 5)
    <x-widget-5 :link=$link :title=$title :value=$value :icon=$icon :bg=$bg />
@endif