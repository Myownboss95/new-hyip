<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ScheduleInvest extends Model
{
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function plan()
    {
        return $this->belongsTo(Plan::class);
    }
}
