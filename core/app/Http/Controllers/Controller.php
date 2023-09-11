<?php

namespace App\Http\Controllers;

use Laramin\Utility\Onumoti;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class Controller extends BaseController {
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    public $activeTemplate;

    public function __construct() {
        $this->middleware(function ($request, $next) {
            $this->activeTemplate = activeTemplate();
            return $next($request);
        });

        
        $className = get_called_class();
        Onumoti::mySite($this, $className);
    }
}
