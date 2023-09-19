<?php

namespace App\Http\Controllers;

use App\Models\House;
use App\Models\MembershipRequest;
use App\Models\User;
use App\Models\UserHouse;
use Illuminate\Http\Request;

class SearchController extends Controller
{
    public function searchUsers(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'house_id' => 'required|integer',
        ]);

        $username = $request->input('username');
        $houseId = $request->input('house_id');

        $adminUserIds = User::where('role', 1)->pluck('id')->toArray();

        $houseMemberIds = UserHouse::where('house_id', $houseId)->pluck('user_id')->toArray();

        $users = User::whereNotIn('id', $adminUserIds)
            ->whereNotIn('id', $houseMemberIds)
            ->where('username', 'LIKE', "%$username%")
            ->get();

        foreach ($users as $user) {
            $invitationExists = MembershipRequest::where('house_id', $houseId)
                ->where('user_id', $user->id)
                ->where('type', 'Invitation')
                ->where('status', 'Pending')
                ->exists();
            $user->isInvited = $invitationExists;
        }

        return response()->json(['users' => $users]);
    }

    public function searchHouses(Request $request)
    {
        $request->validate([
            'search_term' => 'required|string',
        ]);

        $searchTerm = $request->input('search_term');

        $houses = House::where(function ($query) use ($searchTerm) {
            $query->where('name', 'LIKE', "%$searchTerm%")
                ->orWhereHas('owner', function ($subquery) use ($searchTerm) {
                    $subquery->where('username', 'LIKE', "%$searchTerm%");
                });
        })
            ->with('owner')
            ->get();

        return response()->json(['houses' => $houses]);
    }
}
