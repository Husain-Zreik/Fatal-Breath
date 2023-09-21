<?php

namespace App\Http\Controllers;

use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class RoomController extends Controller
{
    public function createRoom(Request $request)
    {
        try {
            $request->validate([
                'house_id' => 'required|exists:houses,id',
                'type' => 'required|in:Kitchen,Bedroom,Livingroom,Bathroom',
                'name' => 'required|string|max:255',
            ]);

            $room = new Room();
            $room->house_id = $request->house_id;
            $room->name = $request->name;
            $room->type = $request->type;
            $room->save();

            return response()->json([
                'status' => 'success',
                'message' => 'Room created successfully',
                'room' => $room,
            ], 201);
        } catch (ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], 422);
        }
    }

    public function deleteRoom($room_id)
    {
        $room = Room::find($room_id);

        if (!$room) {
            return response()->json(['message' => 'Room not found'], 404);
        }

        $room->delete();

        return response()->json(['message' => 'Room deleted successfully']);
    }
}
