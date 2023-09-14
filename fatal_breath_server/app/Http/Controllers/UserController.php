<?php

namespace App\Http\Controllers;

use App\Models\MembershipRequest;
use App\Models\User;
use App\Models\UserHouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;


class UserController extends Controller
{
    public function getUser()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'user' => $user,
        ]);
    }

    public function updateProfile(Request $request)
    {
        try {
            $user = Auth::user();

            $request->validate([
                'name' => 'required|string|max:255',
                'username' => 'required|string|max:255|unique:users,username,' . $user->id,
                'email' => 'required|string|email|max:255|unique:users,email,' . $user->id,
                'profile_image' => 'nullable|string',
            ]);

            $name = $request->input('name');
            $username = $request->input('username');
            $email = $request->input('email');

            if (
                $name === $user->name &&
                $username === $user->username &&
                $email === $user->email &&
                !$request->has('profile_image')
            ) {
                return response()->json([
                    'status' => 'success',
                    'message' => 'No changes were made to the profile',
                    'user' => $user,
                ]);
            }

            $user->name = $request->input('name');
            $user->username = $request->input('username');
            $user->email = $request->input('email');

            if ($request->has('profile_image') && $request->input('profile_image') != null) {

                $encodedImage = $request->input('profile_image');

                $imageData = base64_decode($encodedImage);
                $filename = $username . '.png';

                $imagePath = 'profile_images/' . $filename;
                Storage::disk('public')->put('profile_images/' . $filename, $imageData);

                $user->profile_image = $imagePath;

                // $encodedImage = $request->input('profile_image');

                // $imageData = base64_decode($encodedImage);
                // $filename = $username . '.png';
                // $storagePath = 'public/profile_images/';
                // if ($user->profile_image && Storage::exists($user->profile_image)) {
                //     Storage::delete($user->profile_image);
                // }

                // Storage::put($storagePath . $filename, $imageData);
                // $user->profile_image = $storagePath . $filename;
            }

            // $user->save;
            $user->save();

            return response()->json([
                'status' => 'success',
                'message' => 'Profile updated successfully',
                'user' => $user,
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], 422);
        }
    }

    public function changePassword(Request $request)
    {
        try {
            $user = Auth::user();

            $request->validate([
                'current_password' => 'required|string',
                'new_password' => 'required|string|min:6|confirmed',
            ]);

            if (!Hash::check($request->input('current_password'), $user->password)) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Current password is incorrect',
                ], 401);
            }

            $user->password = Hash::make($request->input('new_password'));
            $user->save();

            return response()->json([
                'status' => 'success',
                'message' => 'Password changed successfully',
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $e->errors(),
            ], 422);
        }
    }


    public function getRequestsAndMembers($houseId)
    {
        $pendingRequests = MembershipRequest::where('house_id', $houseId)
            ->where('status', 'Pending')
            ->with('user')
            ->get();

        $houseMembers = UserHouse::where('house_id', $houseId)
            ->with('user')
            ->get();

        return response()->json([
            'pending_requests' => $pendingRequests,
            'house_members' => $houseMembers
        ]);
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

        if ($status === 'Accepted') {
            $userHouse = new UserHouse();
            $userHouse->user_id = $userId;
            $userHouse->house_id = $houseId;
            $userHouse->save();
        }

        $membershipRequest->delete();

        return response()->json(['message' => 'Membership request processed successfully.']);
    }

    public function sendInvitation(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'house_id' => 'required|exists:houses,id',
        ]);

        if (UserHouse::where('user_id', $request->user_id)->where('house_id', $request->house_id)->exists()) {
            return response()->json(['message' => 'User is already a member of the house.']);
        }

        if (MembershipRequest::where('user_id', $request->user_id)
            ->where('house_id', $request->house_id)
            ->where('type', 'Invitation')
            ->where('status', 'Pending')
            ->exists()
        ) {
            return response()->json(['message' => 'Invitation already sent.']);
        }

        $invitation = new MembershipRequest();
        $invitation->user_id = $request->user_id;
        $invitation->house_id = $request->house_id;
        $invitation->type = 'Invitation';
        $invitation->status = 'Pending';
        $invitation->save();

        return response()->json(['message' => 'Invitation sent successfully.']);
    }



    public function searchUsers(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'house_id' => 'required|integer',
        ]);

        $username = $request->input('username');
        $houseId = $request->input('house_id');

        $usersNotInHouse = User::whereNotIn('id', function ($query) use ($houseId) {
            $query->select('user_id')
                ->from('users_houses')
                ->where('house_id', $houseId);
        })
            ->where('username', 'LIKE', "%$username%")
            ->get();

        $usersNotPendingRequests = User::whereNotIn('id', function ($query) use ($houseId) {
            $query->select('user_id')
                ->from('membership_requests')
                ->where('house_id', $houseId)
                ->where('status', 'Pending');
        })
            ->where('username', 'LIKE', "%$username%")
            ->get();

        $searchResults = $usersNotInHouse->merge($usersNotPendingRequests)->unique();

        return response()->json(['users' => $searchResults]);
    }
}
