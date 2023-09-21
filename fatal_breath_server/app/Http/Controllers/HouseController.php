<?php

namespace App\Http\Controllers;

use App\Models\House;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class HouseController extends Controller
{
    public function createHouse(Request $request)
    {
        try {
            $user = Auth::user();

            $request->validate([
                'name' => 'required|string|max:255',
                'city' => 'required|string|max:255',
                'country' => 'required|string|max:255',
            ]);

            $house = new House();
            $house->owner_id = $user->id;
            $house->name = $request->name;
            $house->city = $request->city;
            $house->country = $request->country;
            $house->save();

            return response()->json([
                'status' => 'success',
                'message' => 'House created successfully',
                'house' => $house,
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], 422);
        }
    }

    public function deleteHouse(Request $request, $house_id)
    {
        try {
            $request->validate([
                'house_id' => 'required|exists:houses,id',
            ]);
            $house = House::find($house_id);

            if (!$house) {
                return response()->json(['message' => 'House not found'], 404);
            }

            $house->delete();

            return response()->json(['message' => 'House deleted successfully']);
        } catch (ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], 422);
        }
    }

    public function getAdminHouses()
    {
        $user = Auth::user();

        $houses = House::with([
            'rooms.sensors',
            'members',
            'requests' => function ($query) {
                $query->where('type', 'Request');
            },
            'requests.user'
        ])->where('owner_id', $user->id)->get();

        $houses = $houses->map(function ($house) {
            $house->rooms = $house->rooms->map(function ($room) {
                $room->hasSensor = $room->sensors->isNotEmpty();
                return $room;
            });
            return $house;
        });

        return response()->json([
            'status' => 'success',
            'message' => 'Houses retrieved successfully',
            'houses' => $houses,
        ]);
    }


    public function getUserHouses()
    {
        $user = Auth::user();

        $houses = $user->houses()
            ->with('owner')
            ->with('rooms.sensors')
            ->with('members')
            ->get();

        $invitedHouses = $user->invitedHouses()
            ->with('owner')
            ->get();

        $houses = $houses->map(function ($house) {
            $house->rooms = $house->rooms->map(function ($room) {
                $room->hasSensor = $room->sensors->isNotEmpty();
                return $room;
            });
            return $house;
        });

        $response = [
            'status' => 'success',
            'message' => 'Houses retrieved successfully',
            'houses' => $houses,
            'invitations' => $invitedHouses,
        ];

        return response()->json($response);
    }
}
