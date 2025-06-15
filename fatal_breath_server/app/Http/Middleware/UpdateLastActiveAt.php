<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Log;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;

class UpdateLastActiveAt
{
    public function handle($request, Closure $next)
    {
        if ($token = JWTAuth::getToken()) {
            try {
                $payload = JWTAuth::getPayload($token);
                $sessionId = $payload->get('jti');

                /** @var \App\Models\User $user */
                $user = auth()->user();

                if ($user && $sessionId) {
                    $user->sessions()
                        ->where('session_id', $sessionId)
                        ->update(['last_active_at' => now()]);
                }
            } catch (\Exception $e) {
                // silently fail — don't block request
                Log::error('Failed to update last active at', [
                    'error' => $e->getMessage(),
                    'token' => $token,
                ]);
            }
        }

        return $next($request);
    }
}
