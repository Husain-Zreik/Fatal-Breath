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
            'co_level' => 'nullable|numeric',
        ]);

        if ($request->has('co_level')) {
            $coLevel = $request->input('co_level');
        } else {
            $coLevel = null;
        }

        $sensor = new Sensor([
            'room_id' => $request->input('room_id'),
            'co_level' => $coLevel,
        ]);
        $sensor->save();

        return response()->json(['message' => 'Sensor record created successfully'], 201);
    }


    public function updateLevel(Request $request)
    {
        $request->validate([
            'room_id' => 'required|exists:rooms,id',
            'co_level' => 'required|numeric',
        ]);

        $roomId = $request->input('room_id');
        $coLevel = $request->input('co_level');

        $sensor = Sensor::where('room_id', $roomId)->first();

        if (!$sensor) {
            return response()->json(['message' => 'Sensor record not found'], 404);
        }

        $sensor->co_level = $coLevel;
        $sensor->save();

        return response()->json(['message' => 'CO level updated successfully']);
    }
}
