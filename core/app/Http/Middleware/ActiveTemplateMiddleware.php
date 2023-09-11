<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Models\Page;


class ActiveTemplateMiddleware {
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next) {
        $viewShare['activeTemplate']     = activeTemplate();
        $viewShare['activeTemplateTrue'] = activeTemplate(true);
        view()->share($viewShare);

        view()->composer([$viewShare['activeTemplate'] . 'partials.header', $viewShare['activeTemplate'] . 'partials.footer'], function ($view) {
            $view->with([
                'pages' => Page::where('is_default', 0)->where('tempname', activeTemplate())->orderBy('id', 'DESC')->get()
            ]);
        });

        return $next($request);
    }
}
