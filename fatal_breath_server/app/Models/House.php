<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class House extends Model
{
    use HasFactory;

    protected $table = 'houses';

    protected $fillable = [
        'name',
        'owner_id',
        'city',
        'country',
    ];

    public function owner()
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    public function rooms()
    {
        return $this->hasMany(Room::class);
    }

    public function members()
    {
        return $this->belongsToMany(User::class, 'users_houses', 'house_id', 'user_id');
    }

    public function joinRequests()
    {
        return $this->hasMany(MembershipRequest::class, 'user_id');
    }

    public function requests()
    {
        return $this->hasMany(MembershipRequest::class, 'house_id')
            ->where('status', 'Pending');
    }
}
