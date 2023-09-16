<?php

namespace App\Http\Controllers;

use App\Models\House;
use App\Models\MembershipRequest;
use App\Models\User;
use App\Models\UserHouse;
use Illuminate\Http\Request;

class ManagerController extends Controller
{
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

    public function processRequest(Request $request)
    {
        $userId = $request->input('user_id');
        $houseId = $request->input('house_id');
        $status = $request->input('status');

        $membershipRequest = MembershipRequest::where('user_id', $userId)
            ->where('house_id', $houseId)
            ->where('status', 'Pending')
            ->first();

        if (!$membershipRequest) {
            return response()->json(['message' => 'Membership request not found.'], 404);
        }

        if ($status === 'Accept') {
            $userHouse = new UserHouse();
            $userHouse->user_id = $userId;
            $userHouse->house_id = $houseId;
            $userHouse->save();
        }

        $membershipRequest->delete();

        return response()->json(['message' => 'Membership request processed successfully.']);
    }

    public function toggleInvitation(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'house_id' => 'required|exists:houses,id',
        ]);

        $existingInvitation = MembershipRequest::where('user_id', $request->user_id)
            ->where('house_id', $request->house_id)
            ->where('type', 'Invitation')
            ->where('status', 'Pending')
            ->first();

        if ($existingInvitation) {
            $existingInvitation->delete();
            return response()->json(['message' => 'Invitation canceled successfully.']);
        } else {
            if (UserHouse::where('user_id', $request->user_id)->where('house_id', $request->house_id)->exists()) {
                return response()->json(['message' => 'User is already a member of the house.']);
            }

            $invitation = new MembershipRequest();
            $invitation->user_id = $request->user_id;
            $invitation->house_id = $request->house_id;
            $invitation->type = 'Invitation';
            $invitation->status = 'Pending';
            $invitation->save();

            return response()->json(['message' => 'Invitation sent successfully.']);
        }
    }

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

        $pendingRequestIds = MembershipRequest::where('house_id', $houseId)
            ->where('status', 'Pending')
            ->pluck('user_id')->toArray();

        $usersNotInHouse = User::whereNotIn('id', $adminUserIds)
            ->whereNotIn('id', $houseMemberIds)
            ->whereNotIn('id', $pendingRequestIds)
            ->where('username', 'LIKE', "%$username%")
            ->get();

        return response()->json(['users' => $usersNotInHouse]);
    }
}
