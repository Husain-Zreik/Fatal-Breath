<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserHouse extends Model
{
    use HasFactory;

    protected $table = 'users_houses';

    protected $fillable = [
        'user_id',
        'house_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function house()
    {
        return $this->belongsTo(House::class);
    }
}
