<?php

namespace App\Http\Controllers;

use App\Http\Services\FCMService;
use App\Models\Room;
use App\Models\Sensor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class SensorController extends Controller
{
    public function connect(Request $request)
    {
        $request->validate([
            'room_id' => 'required|exists:rooms,id',
            'co_level' => 'nullable|numeric',
        ]);

        $existingSensor = Sensor::where('room_id', $request->input('room_id'))->first();

        if ($existingSensor) {
            return response()->json(['message' => 'This room is already connected to a sensor'], 400);
        }

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
        Log::info('updateLevel() called', ['payload' => $request->all()]);

        $request->validate([
            'room_id' => 'required|exists:rooms,id',
            'co_level' => 'required|numeric',
        ]);

        $roomId = $request->input('room_id');
        $coLevel = $request->input('co_level');

        Log::info('Validated input', ['room_id' => $roomId, 'co_level' => $coLevel]);

        $sensor = Sensor::where('room_id', $roomId)->first();

        if (!$sensor) {
            Log::warning('Sensor not found', ['room_id' => $roomId]);
            return response()->json(['message' => 'Sensor record not found'], 404);
        }

        $previousLevel = $sensor->co_level;
        Log::info('Previous CO level retrieved', ['previous_level' => $previousLevel]);

        $sensor->co_level = $coLevel;
        $sensor->save();
        Log::info('Sensor CO level updated', ['new_level' => $coLevel]);

        if (
            ($previousLevel <= 40 && $coLevel > 40) ||
            ($previousLevel <= 70 && $coLevel > 70)
        ) {
            Log::info('Threshold crossed, preparing to notify users', [
                'previous_level' => $previousLevel,
                'new_level' => $coLevel
            ]);

            $room = Room::with('house.owner', 'house.members')->find($roomId);

            if (!$room) {
                Log::error('Room not found after sensor update', ['room_id' => $roomId]);
                return response()->json(['message' => 'Room not found'], 404);
            }

            $owner = $room->house->owner;
            $members = $room->house->members;

            $users = $members->push($owner)->unique('id');
            Log::info('Users to notify compiled', ['user_ids' => $users->pluck('id')]);

            $notification = [
                'title' => 'CO Level Alert',
                'body'  => $coLevel > 70
                    ? "⚠️ DANGEROUS: CO Level is now {$coLevel}%"
                    : "⚠️ SENSITIVE: CO Level crossed 40%, now {$coLevel}%",
            ];

            foreach ($users as $user) {
                $sessions = $user->sessions()->whereNotNull('device_token')->get();
                Log::info('User sessions retrieved', [
                    'user_id' => $user->id,
                    'token_count' => $sessions->count()
                ]);

                foreach ($sessions as $session) {
                    $fcmToken = $session->device_token;

                    try {
                        FCMService::send($fcmToken, $notification);
                        Log::info('FCM notification sent', [
                            'user_id' => $user->id,
                            'token' => $fcmToken
                        ]);
                    } catch (\Throwable $e) {
                        Log::error('Failed to send FCM Notification in updateLevel()', [
                            'exception_message' => $e->getMessage(),
                            'room_id' => $roomId,
                            'user_id' => $user->id,
                            'co_level' => $coLevel,
                            'token' => $fcmToken,
                        ]);
                    }
                }
            }
        } else {
            Log::info('Threshold not crossed, no notification sent', [
                'previous_level' => $previousLevel,
                'new_level' => $coLevel
            ]);
        }

        return response()->json(['message' => 'CO level updated successfully']);
    }
}
