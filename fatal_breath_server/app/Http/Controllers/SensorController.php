<?php

namespace App\Http\Controllers;

use App\Models\Sensor;
use Illuminate\Http\Request;

class SensorController extends Controller
{
    public function connect(Request $request)
    {
        $request->validate([
            'room_id' => 'required|exists:rooms,id',
            'co_level' => 'required|numeric',
        ]);

        $sensor = new Sensor([
            'room_id' => $request->input('room_id'),
            'co_level' => $request->input('co_level'),
        ]);
        $sensor->save();

        return response()->json(['message' => 'Sensor record created successfully'], 201);
    }
}
