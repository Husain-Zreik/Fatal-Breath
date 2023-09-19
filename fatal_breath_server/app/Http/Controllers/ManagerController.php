<?php

namespace App\Http\Controllers;

use App\Models\House;
use App\Models\MembershipRequest;
use App\Models\User;
use App\Models\UserHouse;
use Illuminate\Http\Request;

class ManagerController extends Controller
{

    public function processRequest(Request $request)
    {
        $userId = $request->input('user_id');
        $houseId = $request->input('house_id');
        $status = $request->input('status');

        $membershipRequest = MembershipRequest::where('user_id', $userId)
            ->where('house_id', $houseId)
            ->where('type', 'Request')
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
}
