<?php

namespace App\Http\Services;

use Illuminate\Support\Facades\Http;

class FCMService
{
    public static function send($token, $notification)
    {
        $fcmServerKey = 'AAAABO6wM3s:APA91bEn6u-6NPtmAi58nflNCyZLEN_iyG8wMSsej-S4SwQ80CoQ06AX0oSn0U6CXnyImiX3jPfYMEBkGAF9_VkGXrG93IDEJuhG33K1OBpTFM1zebu0qt8fgGiSTnxhf2Hb8JeL2n8n';

        Http::withHeaders([
            'Authorization' => 'key=' . $fcmServerKey,
            'Content-Type' => 'application/json',
        ])->post(
            'https://fcm.googleapis.com/fcm/send',
            [
                'notification' => $notification,
                'to' => $token,
            ]
        );
    }
}
