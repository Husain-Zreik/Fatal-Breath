<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator as FacadesValidator;
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

            if ($request->has('profile_image')) {

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
}
