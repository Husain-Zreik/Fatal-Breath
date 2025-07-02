<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Faker\Factory as Faker;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        $faker = Faker::create();

        // Clear tables (optional)
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');

        DB::table('sensors')->truncate();
        DB::table('rooms')->truncate();
        DB::table('houses')->truncate();
        DB::table('users_houses')->truncate();
        DB::table('membership_requests')->truncate();
        DB::table('sessions')->truncate();
        DB::table('users')->truncate();

        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        $password = Hash::make('123456');

        // Create 5 Managers
        $managers = [];
        for ($i = 1; $i <= 5; $i++) {
            $managers[] = DB::table('users')->insertGetId([
                'name' => $faker->name,
                'username' => "manager{$i}",
                'email' => "manager{$i}@example.com",
                'role' => 1,
                'password' => $password,
                'profile_image' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // Create 10 Members
        $members = [];
        for ($i = 1; $i <= 10; $i++) {
            $members[] = DB::table('users')->insertGetId([
                'name' => $faker->name,
                'username' => "member{$i}",
                'email' => "member{$i}@example.com",
                'role' => 0,
                'password' => $password,
                'profile_image' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        $roomTypes = ['Kitchen', 'Bedroom', 'Livingroom', 'Bathroom'];

        $houses = [];

        // For each manager create 3 houses
        foreach ($managers as $managerId) {
            for ($h = 1; $h <= 3; $h++) {
                $houseId = DB::table('houses')->insertGetId([
                    'name' => ucfirst($faker->word) . " Estate",
                    'owner_id' => $managerId,
                    'city' => $faker->city,
                    'country' => $faker->country,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
                $houses[] = $houseId;

                // Create 4 rooms for each house
                for ($r = 0; $r < 4; $r++) {
                    $roomId = DB::table('rooms')->insertGetId([
                        'house_id' => $houseId,
                        'type' => $roomTypes[$r],
                        'name' => $roomTypes[$r] . " " . ($r + 1),
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);

                    // Create 1 or 2 sensors for each room
                    $sensorCount = rand(1, 2);
                    for ($s = 0; $s < $sensorCount; $s++) {
                        DB::table('sensors')->insert([
                            'room_id' => $roomId,
                            'co_level' => rand(10, 90),
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                    }
                }
            }
        }

        // Assign members to houses randomly (each member in 3-5 houses)
        foreach ($members as $memberId) {
            $assignedHouseIds = $faker->randomElements($houses, rand(3, 5));
            foreach ($assignedHouseIds as $houseId) {
                DB::table('users_houses')->insert([
                    'user_id' => $memberId,
                    'house_id' => $houseId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                // Create membership request accepted for this user/house
                DB::table('membership_requests')->insert([
                    'user_id' => $memberId,
                    'house_id' => $houseId,
                    'type' => 'Request',
                    'status' => 'Accepted',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        // Create some pending and declined membership requests for members
        foreach ($members as $memberId) {
            // Random house that user not in
            $notInHouses = array_diff($houses, DB::table('users_houses')->where('user_id', $memberId)->pluck('house_id')->toArray());
            $randomHouses = $faker->randomElements($notInHouses, min(2, count($notInHouses)));

            foreach ($randomHouses as $houseId) {
                DB::table('membership_requests')->insert([
                    'user_id' => $memberId,
                    'house_id' => $houseId,
                    'type' => 'Request',
                    'status' => $faker->randomElement(['Pending', 'Declined']),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        // Create sessions for all users (managers + members)
        $allUsers = array_merge($managers, $members);
        foreach ($allUsers as $userId) {
            DB::table('sessions')->insert([
                'user_id' => $userId,
                'session_id' => $faker->uuid,
                'device_name' => $faker->userAgent,
                'device_token' => $faker->uuid,
                'ip_address' => $faker->ipv4,
                'user_agent' => $faker->userAgent,
                'last_active_at' => now()->subMinutes(rand(0, 30)),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
