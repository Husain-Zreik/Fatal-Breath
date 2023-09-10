<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::group(['prefix' => 'auth'], function () {

    Route::get("unauthorized", [AuthController::class, "unauthorized"])->name("unauthorized");
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);
});

Route::group(['prefix' => 'user', 'middleware' => 'auth:api'], function () {

    Route::group(['prefix' => 'admin',  'middleware' => 'auth.admin'], function () {
    });

    Route::group(['prefix' => 'member',  'middleware' => 'auth.member'], function () {
    });

    Route::get("/info", [UserController::class, "getUser"]);

    Route::post("logout", [AuthController::class, "logout"]);
    Route::post("refresh", [AuthController::class, "refresh"]);
});
