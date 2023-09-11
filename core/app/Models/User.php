<?php

namespace App\Models;

use App\Traits\Searchable;
use App\Traits\UserNotify;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use HasApiTokens, Searchable, UserNotify;

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token', 'ver_code', 'balance', 'kyc_data',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'address'           => 'object',
        'kyc_data'          => 'object',
        'ver_code_send_at'  => 'datetime',
    ];

    public function loginLogs()
    {
        return $this->hasMany(UserLogin::class);
    }

    public function transactions()
    {
        return $this->hasMany(Transaction::class)->orderBy('id', 'desc');
    }

    public function deposits()
    {
        return $this->hasMany(Deposit::class)->where('status', '!=', 0);
    }

    public function withdrawals()
    {
        return $this->hasMany(Withdrawal::class)->where('status', '!=', 0);
    }

    public function referrer()
    {
        return $this->belongsTo(User::class, 'ref_by');
    }

    public function referrals()
    {
        return $this->hasMany(User::class, 'ref_by');
    }

    public function activeReferrals()
    {
        return $this->hasMany(User::class, 'ref_by')->whereHas('invests');
    }

    public function allReferrals()
    {
        return $this->referrals()->with('referrer');
    }

    public function invests()
    {
        return $this->hasMany(Invest::class)->orderBy('id', 'desc');
    }

    public function scheduleInvests()
    {
        return $this->hasMany(ScheduleInvest::class);
    }
    
    public function stakingInvests()
    {
        return $this->hasMany(StakingInvest::class);
    }
    
    public function poolInvests()
    {
        return $this->hasMany(PoolInvest::class);
    }

    public function userRanking()
    {
        return $this->belongsTo(UserRanking::class);
    }

    public function fullname(): Attribute
    {
        return new Attribute(
            get:fn() => $this->firstname . ' ' . $this->lastname,
        );
    }

    // SCOPES
    public function scopeActive($query)
    {
        return $query->where('status', 1)->where('ev', '1')->where('sv', 1);
    }

    public function scopeBanned($query)
    {
        return $query->where('status', 0);
    }

    public function scopeEmailUnverified($query)
    {
        return $query->where('ev', 0);
    }

    public function scopeMobileUnverified($query)
    {
        return $query->where('sv', 0);
    }

    public function scopeKycUnverified($query)
    {
        return $query->where('kv', 0);
    }

    public function scopeKycPending($query)
    {
        return $query->where('kv', 2);
    }

    public function scopeEmailVerified($query)
    {
        return $query->where('ev', 1);
    }

    public function scopeMobileVerified($query)
    {
        return $query->where('sv', 1);
    }

    public function scopeWithBalance($query)
    {
        return $query->where(function ($userWallet) {
            $userWallet->where('deposit_wallet', '>', 0)->orWhere('interest_wallet', '>', 0);
        });
    }

    public function deviceTokens()
    {
        return $this->hasMany(DeviceToken::class);
    }

}
