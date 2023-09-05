<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class AuthUser
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = Auth::user();
        $type =  $user->role;

        if ($type == 0) {
            return $next($request);
        }

        return redirect()->route("unauthorized");
    }
}
