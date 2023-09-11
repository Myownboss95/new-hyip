<?php

namespace App\Models;

use App\Traits\GlobalStatus;
use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{
    use GlobalStatus;
    
    public function invests()
    {
        return $this->hasMany(Invest::class);
    }

    public function timeSetting()
    {
        return $this->belongsTo(TimeSetting::class);
    }
}
