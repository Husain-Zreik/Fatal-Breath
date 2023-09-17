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

    public function getAdminHouses()
    {
        $user = Auth::user();

        $houses = House::with([
            'rooms',
            'members',
            'requests' => function ($query) {
                $query->where('type', 'Request');
            },
            'requests.user'
        ])->where('owner_id', $user->id)->get();

        return response()->json([
            'status' => 'success',
            'message' => 'Houses retrieved successfully',
            'houses' => $houses,
        ]);
    }

    public function getUserHouses()
    {
        $user = Auth::user();

        $houses = $user->houses()->with('rooms', 'members')->get();

        // You can customize the response format as needed
        $response = [
            'status' => 'success',
            'message' => 'Houses retrieved successfully',
            'houses' => $houses,
        ];

        return response()->json($response);
    }
}
