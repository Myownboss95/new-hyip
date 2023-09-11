<?php

namespace App\Models;

use App\Traits\GlobalStatus;
use Illuminate\Database\Eloquent\Model;

class Pool extends Model
{
    use GlobalStatus;

    public function scopeActive($query)
    {
        $query->where('status', 1)->where('start_date', '>', now());
    }

    public function poolInvests()
    {
        return $this->hasMany(PoolInvest::class);
    }
    
}
