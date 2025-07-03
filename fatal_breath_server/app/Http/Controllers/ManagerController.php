<?php

namespace App\Http\Controllers;

use App\Models\House;
use App\Models\MembershipRequest;
use App\Models\Room;
use App\Models\Sensor;
use App\Models\User;
use App\Models\UserHouse;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ManagerController extends Controller
{

    public function overview(Request $request)
    {
        $managerId = auth()->id();

        // Manager's houses
        $houses = House::where('owner_id', $managerId)->withCount('rooms')->get();
        $houseIds = $houses->pluck('id');

        // Rooms in manager's houses
        $rooms = Room::whereIn('house_id', $houseIds)->get();
        $roomIds = $rooms->pluck('id');

        // Sensors
        $sensors = Sensor::whereIn('room_id', $roomIds)->get();
        $totalSensors = $sensors->count();

        // Sensor analysis
        $unsafeSensors = $sensors->where('co_level', '>=', 70);
        $mediumSensors = $sensors->whereBetween('co_level', [50, 69]);
        $inactiveSensors = $sensors->where('updated_at', '<', now()->subMinutes(10))->count();

        // Rooms with no sensors
        $roomsWithSensors = $sensors->pluck('room_id')->unique();
        $roomsWithoutSensorsCount = $roomIds->diff($roomsWithSensors)->count();

        // Active members (from sessions)
        $activeUserIds = UserHouse::whereIn('house_id', $houseIds)->pluck('user_id')->unique();
        $activeMembersCount = \App\Models\Session::whereIn('user_id', $activeUserIds)
            ->where('last_active_at', '>=', now()->subMinutes(10))
            ->count();

        return response()->json([
            'houses' => $houses->count(),
            'rooms' => $rooms->count(),
            'unsafeRooms' => $unsafeSensors->count(),
            'mediumRiskRooms' => $mediumSensors->count(),
            'activeMembers' => $activeMembersCount,
            'systemHealth' => [
                'inactiveSensors' => $inactiveSensors,
                'roomsWithoutSensors' => $roomsWithoutSensorsCount,
            ],
        ]);
    }

    public function getMembers()
    {
        try {
            /** @var \App\Models\User $user */
            $user = Auth::user();

            $members = $user->members();

            return response()->json([
                'message' => 'Members fetched successfully.',
                'members' => $members,
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'message' => 'Failed to fetch members.',
                'error' => $th->getMessage(),
            ], 500);
        }
    }

    public function removeMember(Request $request, House $house, User $user)
    {
        $authUser = Auth::user();

        // Ensure the authenticated user owns the house
        if ($house->owner_id !== $authUser->id) {
            return response()->json([
                'message' => 'Unauthorized to modify this house.'
            ], 403);
        }

        // Check if the user is a member of the house
        if (!$house->members()->where('user_id', $user->id)->exists()) {
            return response()->json([
                'message' => 'User is not a member of this house.'
            ], 404);
        }

        // Detach the user from the house
        $house->members()->detach($user->id);

        return response()->json([
            'message' => 'Member removed successfully from the house.'
        ]);
    }

    public function getMembershipRequests()
    {
        // Get all house IDs the authenticated manager owns
        $managerId = auth()->id(); // Make sure middleware `auth:sanctum` is applied
        $houseIds = House::where('owner_id', $managerId)->pluck('id');

        // Fetch membership requests for those houses
        $requests = MembershipRequest::with(['user:id,name,email,profile_image', 'house:id,name'])
            ->whereIn('house_id', $houseIds)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'requests' => $requests,
        ]);
    }

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
