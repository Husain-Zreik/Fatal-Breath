<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Str;
use Faker\Factory as Faker;
use App\Models\User;

class UserSeeder extends Seeder
{
    public function run()
    {
        $faker = Faker::create();

        for ($i = 0; $i < 1000; $i++) {
            User::create([
                'name' => Str::limit($faker->name(), 12),
                'username' => Str::limit($faker->username(), 12),
                'email' => $faker->email(),
                'role' => $faker->boolean(),
                'password' => bcrypt('123456'),
                'profile_image' => null,
            ]);
        }
    }
}
