<?php

namespace App\Models;

use App\Traits\GlobalStatus;
use Illuminate\Database\Eloquent\Model;

class Staking extends Model
{
    use GlobalStatus;
    
    public function scopeActive($query)
    {
        return $query->where('status', 1);
    }
}
