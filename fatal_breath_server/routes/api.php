<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\HouseController;
use App\Http\Controllers\RoomController;
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
        Route::post("/add-room", [RoomController::class, "createRoom"]);
        Route::post("/add-house", [HouseController::class, "createHouse"]);
        Route::get("/get-houses", [HouseController::class, "getHouses"]);
        Route::get("/house/search", [UserController::class, "searchUsers"]);
        Route::get("/house/get-requests", [UserController::class, "getRequests"]);
        Route::post('/process-request', [UserController::class, "processRequest"]);
    });

    Route::group(['prefix' => 'member',  'middleware' => 'auth.member'], function () {
    });

    Route::get("/info", [UserController::class, "getUser"]);
    Route::post("/info/update", [UserController::class, "updateProfile"]);
    Route::post('/info/change-password', [UserController::class, 'changePassword']);


    Route::post("logout", [AuthController::class, "logout"]);
    Route::post("refresh", [AuthController::class, "refresh"]);
});
