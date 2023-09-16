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

    public function getHouses()
    {
        $user = Auth::user();

        $houses = House::with(['rooms', 'members', 'requests.user'])->where('owner_id', $user->id)->get();

        return response()->json([
            'status' => 'success',
            'message' => 'Houses retrieved successfully',
            'houses' => $houses,
        ]);
    }

    public function removeMember($houseId, $userId)
    {
        $house = House::find($houseId);
        $user = User::find($userId);

        if (!$house || !$user) {
            return response()->json(['message' => 'House or user not found'], 404);
        }

        if (!$house->members()->where('user_id', $userId)->exists()) {
            return response()->json(['message' => 'User is not a member of this house'], 400);
        }

        $house->members()->detach($userId);

        return response()->json(['message' => 'User removed from the house successfully']);
    }
}
