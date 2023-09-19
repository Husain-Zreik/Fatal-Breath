<?php

namespace App\Http\Controllers;

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
}
