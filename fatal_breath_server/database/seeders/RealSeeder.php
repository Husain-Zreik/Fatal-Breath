<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Faker\Factory as Faker;

class RealSeeder extends Seeder
{
    public function run()
    {
        $faker = Faker::create();

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

        // List of real users (first 12)
        $realUsers = [
            ['name' => 'Ali Raed', 'username' => 'ali.raed'],
            ['name' => 'Ali Abou Melhem', 'username' => 'ali.aboumelhem'],
            ['name' => 'Adnan Al Haj', 'username' => 'adnan.alhaj'],
            ['name' => 'Walid Fahs', 'username' => 'walid.fahs'],
            ['name' => 'Layyale Hajjar', 'username' => 'layyale.hajjar'],
            ['name' => 'Rabih Wazni', 'username' => 'rabih.wazni'],
            ['name' => 'Khaled Zain', 'username' => 'khaled.zain'],
            ['name' => 'Hussein Zreik', 'username' => 'hussein.zreik'],
            ['name' => 'Jana Allouch', 'username' => 'jana.allouch'],
            ['name' => 'Mohammad Al Haj', 'username' => 'mohammad.alhaj'],
            ['name' => 'Ali Mokdad', 'username' => 'ali.mokdad'],
            ['name' => 'Zainab Al Haj', 'username' => 'zainab.alhaj'],
        ];

        $managers = [];
        $members = [];

        // Seed real users
        $password = Hash::make('123456');
        foreach ($realUsers as $index => $user) {
            $role = $index < 5 ? 1 : 0; // first 5 are managers
            $userId = DB::table('users')->insertGetId([
                'name' => $user['name'],
                'username' => $user['username'],
                'email' => $user['username'] . '@gmail.com',
                'role' => $role,
                'password' => $password,
                'profile_image' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            if ($role === 1) {
                $managers[] = $userId;
            } else {
                $members[] = $userId;
            }
        }

        // Add 8 more Faker-generated members
        for ($i = 1; $i <= 8; $i++) {
            $userId = DB::table('users')->insertGetId([
                'name' => $faker->name,
                'username' => 'member' . ($i + 12),
                'email' => 'member' . ($i + 12) . '@example.com',
                'role' => 0,
                'password' => $password,
                'profile_image' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            $members[] = $userId;
        }

        // House names (short common names)
        $roomTypes = ['Kitchen', 'Bedroom', 'Livingroom', 'Bathroom'];
        $houseNames = [
            'Maple',
            'Cedar',
            'Pine',
            'Oak',
            'Elm',
            'Spruce',
            'Birch',
            'Willow',
            'Ash',
            'Rose',
            'Ivy',
            'Juniper',
            'Palm',
            'Holly',
            'Cove',
            'Glen',
            'Heath',
            'Lake',
            'Hill',
            'Vale',
            'Bluff',
            'Dale',
            'Creek',
            'Bay',
            'Shore',
            'Wren',
            'Fawn',
            'Reef',
            'Cliff',
            'Meadow'
        ];

        $houses = [];
        $usedHouseNames = [];

        foreach ($managers as $managerId) {
            $availableNames = array_diff($houseNames, $usedHouseNames);
            $selectedNames = $faker->randomElements($availableNames, 5);
            $usedHouseNames = array_merge($usedHouseNames, $selectedNames);

            foreach ($selectedNames as $houseName) {
                $houseId = DB::table('houses')->insertGetId([
                    'name' => $houseName,
                    'owner_id' => $managerId,
                    'city' => $faker->city,
                    'country' => $faker->country,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
                $houses[] = $houseId;

                foreach ($roomTypes as $rIndex => $type) {
                    $roomId = DB::table('rooms')->insertGetId([
                        'house_id' => $houseId,
                        'type' => $type,
                        'name' => $type . ' ' . ($rIndex + 1),
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);

                    for ($s = 0; $s < rand(1, 2); $s++) {
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

        foreach ($members as $memberId) {
            $assignedHouseIds = $faker->randomElements($houses, rand(3, 5));
            foreach ($assignedHouseIds as $houseId) {
                DB::table('users_houses')->insert([
                    'user_id' => $memberId,
                    'house_id' => $houseId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

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

        foreach ($members as $memberId) {
            $joined = DB::table('users_houses')->where('user_id', $memberId)->pluck('house_id')->toArray();
            $notInHouses = array_diff($houses, $joined);
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

        foreach (array_merge($managers, $members) as $userId) {
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
