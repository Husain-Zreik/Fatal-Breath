<?php

namespace App\Http\Controllers;

use App\Http\Services\FCMService;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    // public function sendNotification(Request $request)
    // {

    //     $user = $request->to;

    //     FCMService::send(
    //         $user,
    //         [
    //             'title' => 'hey there beautiful',
    //             'body' => 'your body is tired',
    //         ]
    //     );

    //     return response()->json([
    //         'status' => 'success',
    //         'user' => $user
    //     ]);
    // }

    public function sendNotification(Request $request)
    {
        $deviceToken = $request->input('to');
        $notificationData = $request->input('notification');

        FCMService::send(
            $deviceToken,
            $notificationData
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Notification sent successfully',
        ]);
    }
}
