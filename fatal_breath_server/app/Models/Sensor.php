<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sensor extends Model
{
    use HasFactory;

    protected $table = 'sensors';

    protected $fillable = [
        'room_id',
        'co2_level',
    ];

    public function room()
    {
        return $this->belongsTo(Room::class);
    }
}
