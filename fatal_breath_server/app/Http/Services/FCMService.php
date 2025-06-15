<?php

namespace App\Http\Services;

use Google\Auth\Credentials\ServiceAccountCredentials;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class FCMService
{
    public static function send($token, $notification)
    {
        $projectId = 'fatal-breath';
        $serviceAccountPath = storage_path('firebase/service-account.json');

        Log::info('FCM Info', [
            'token' => $token,
            'notification' => $notification,
        ]);

        try {
            $credentials = new ServiceAccountCredentials(
                'https://www.googleapis.com/auth/firebase.messaging',
                json_decode(file_get_contents($serviceAccountPath), true)
            );

            $authToken = $credentials->fetchAuthToken();
            $accessToken = $authToken['access_token'];

            $message = [
                'message' => [
                    'token' => $token,
                    'notification' => $notification, // Must contain 'title' and 'body'
                ]
            ];

            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $accessToken,
                'Content-Type' => 'application/json',
            ])->post("https://fcm.googleapis.com/v1/projects/{$projectId}/messages:send", $message);

            if ($response->failed()) {
                $errorData = $response->json(); // <-- Decode JSON response to array

                Log::error('FCM v1 Send Failed', [
                    'response' => $errorData,
                    'token' => $token,
                    'notification' => $notification,
                ]);

                // throw a structured exception
                throw new \Exception(json_encode([
                    'message' => 'FCM v1 Send Failed',
                    'fcm_error' => $errorData,
                ]));
            }

            return $response->json(); // Optionally return FCM response
        } catch (\Throwable $e) {
            Log::error('FCM v1 Send Exception: ' . $e->getMessage());
            throw $e; // ✅ rethrow for controller to catch
        }
    }
}
