<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('users_houses', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('house_id');
            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('users')->cascadeOnDelete();
            $table->foreign('house_id')->references('id')->on('houses')->cascadeOnDelete();
        });

        Schema::create('membership_requests', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('house_id');
            $table->enum('type', ['Request', 'Invitation']);
            $table->enum('status', ['Pending', 'Accepted', 'Declined']);
            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('users')->cascadeOnDelete();
            $table->foreign('house_id')->references('id')->on('houses')->cascadeOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('users_houses');
        Schema::dropIfExists('membership_requests');
    }
};
