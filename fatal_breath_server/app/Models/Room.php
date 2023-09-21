<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    use HasFactory;

    protected $table = 'rooms';

    protected $fillable = [
        'house_id',
        'type',
        'name',
        'size',
    ];

    public function house()
    {
        return $this->belongsTo(House::class);
    }

    public function sensor()
    {
        return $this->hasOne(Sensor::class);
    }
}
