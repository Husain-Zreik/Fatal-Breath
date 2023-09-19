<?php

namespace App\Http\Controllers;

use App\Models\House;
use App\Models\MembershipRequest;
use App\Models\User;
use App\Models\UserHouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

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

        $user = Auth::user();
        $searchTerm = $request->input('search_term');

        $userHouseIds = $user->houses()->pluck('houses.id')->toArray();

        $pendingInvitationHouseIds = MembershipRequest::where('user_id', $user->id)
            ->where('type', 'Invitation')
            ->where('status', 'Pending')
            ->pluck('house_id')
            ->toArray();

        $houses = House::where(function ($query) use ($searchTerm) {
            $query->where('houses.name', 'LIKE', "%$searchTerm%")
                ->orWhereHas('owner', function ($subquery) use ($searchTerm) {
                    $subquery->where('users.username', 'LIKE', "%$searchTerm%");
                });
        })
            ->with('owner')
            ->whereNotIn('houses.id', $userHouseIds)
            ->whereNotIn('houses.id', $pendingInvitationHouseIds)
            ->get();

        foreach ($houses as $house) {
            $requestExists = MembershipRequest::where('user_id', $user->id)
                ->where('house_id', $house->id)
                ->where('type', 'Request')
                ->where('status', 'Pending')
                ->exists();
            $house->isRequested = $requestExists;
        }

        return response()->json(['houses' => $houses]);
    }
}
