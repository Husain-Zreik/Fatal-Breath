<?php

namespace App\Http\Controllers;

use Illuminate\Validation\ValidationException;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\User;

class AuthController extends Controller
{

    public function unauthorized()
    {
        return response()->json([
            'status' => 'Failed',
            'message' => 'unauthorized',
        ]);
    }

    public function checkTokenValidity()
    {
        $user = Auth::user();

        if ($user) {
            return response()->json([
                'status' => 'success',
                'message' => 'Token is valid',
                'user' => $user,
            ]);
        }

        return response()->json([
            'status' => 'error',
            'message' => 'Token is invalid',
        ], 401);
    }


    public function register(Request $request)
    {
        try {
            $request->validate([
                'name' => 'required|string|max:255',
                'username' => 'required|string|max:255|unique:users',
                'email' => 'required|string|email|max:255|unique:users',
                'role' => 'required|boolean',
                'password' => 'required|string|min:6',
            ]);

            $user = User::create([
                'name' => $request->name,
                'username' => $request->username,
                'role' => $request->role,
                'email' => $request->email,
                'password' => Hash::make($request->password),
            ]);

            $token = Auth::login($user);
            $user->token = $token;

            return response()->json([
                'status' => 'success',
                'message' => 'User created successfully',
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

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only('email', 'password');
        $deviceName = $request->input('device_name');
        $deviceToken = $request->input('fcm_token');
        $ip = $request->ip();

        // Custom claims
        $customClaims = [];
        if ($deviceName && $deviceToken) {
            $customClaims = [
                'device_name' => $deviceName,
                'device_token' => $deviceToken,
                'jti' => (string) Str::uuid(),
            ];
        }

        $token = Auth::claims($customClaims)->attempt($credentials);

        if (!$token) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized',
            ], 401);
        }

        /** @var \App\Models\User $user */
        $user = Auth::user();
        $user->token = $token;

        if ($deviceName && $deviceToken) {
            $payload = JWTAuth::setToken($token)->getPayload();
            $sessionId = $payload->get('jti');

            // Clean any prior session with same device + IP
            $user->sessions()
                ->where('device_token', $deviceToken)
                ->delete();

            $user->sessions()->create([
                'session_id' => $sessionId,
                'device_name' => $deviceName,
                'device_token' => $deviceToken,
                'ip_address' => $ip,
                'user_agent' => $request->userAgent(),
                'last_active_at' => now(),
            ]);
        }

        return response()->json([
            'status' => 'success',
            'user' => $user,
        ]);
    }

    public function logout(Request $request)
    {
        try {
            $token = JWTAuth::getToken();

            if (!$token) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Token not provided',
                ], 400);
            }

            $payload = JWTAuth::getPayload($token);
            $sessionId = $payload->get('jti');

            // Delete the session from DB
            /** @var \App\Models\User $user */
            $user = Auth::user();
            if ($user && $sessionId) {
                $user->sessions()->where('session_id', $sessionId)->delete();
            }

            JWTAuth::invalidate($token); // Invalidate token

            return response()->json([
                'status' => 'success',
                'message' => 'Successfully logged out',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to logout',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function refresh(Request $request)
    {
        try {
            $oldToken = JWTAuth::getToken();

            if (!$oldToken) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Token not provided',
                ], 400);
            }

            $oldPayload = JWTAuth::getPayload($oldToken);
            $oldSessionId = $oldPayload->get('jti');

            $deviceName = $oldPayload->get('device_name');
            $deviceToken = $oldPayload->get('device_token');

            $newClaims = [];
            if ($deviceName && $deviceToken) {
                $newClaims = [
                    'device_name' => $deviceName,
                    'device_token' => $deviceToken,
                    'jti' => (string) Str::uuid(),
                ];
            }

            $newToken = Auth::claims($newClaims)->refresh();

            /** @var \App\Models\User $user */
            $user = Auth::user();
            $user->token = $newToken;

            // Remove old session
            if ($user && $oldSessionId) {
                $user->sessions()->where('session_id', $oldSessionId)->delete();
            }

            // Add new session
            if ($deviceName && $deviceToken) {
                $newPayload = JWTAuth::setToken($newToken)->getPayload();
                $newSessionId = $newPayload->get('jti');

                // Remove any prior sessions for same device + IP
                $user->sessions()
                    ->where('device_token', $deviceToken)
                    ->delete();

                $user->sessions()->create([
                    'session_id' => $newSessionId,
                    'device_name' => $deviceName,
                    'device_token' => $deviceToken,
                    'ip_address' => $request->ip(),
                    'user_agent' => $request->userAgent(),
                    'last_active_at' => now(),
                ]);
            }

            return response()->json([
                'status' => 'success',
                'user' => $user,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Token refresh failed',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
