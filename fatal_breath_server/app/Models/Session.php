<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Session extends Model
{
    protected $table = 'sessions';

    // Mass assignable fields
    protected $fillable = [
        'user_id',
        'session_id',
        'device_name',
        'device_token',    // FCM device token
        'ip_address',
        'user_agent',
        'last_active_at',
    ];

    // Cast dates automatically
    protected $dates = [
        'last_active_at',
        'created_at',
        'updated_at',
    ];

    /**
     * Define the relationship back to the User
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
