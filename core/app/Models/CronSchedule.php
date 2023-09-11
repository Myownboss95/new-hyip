<?php

namespace App\Models;

use App\Traits\GlobalStatus;
use Illuminate\Database\Eloquent\Model;

class CronSchedule extends Model
{
    use GlobalStatus;

    public function scopeActive($query)
    {
        $query->where('status', 1);
    }

}
