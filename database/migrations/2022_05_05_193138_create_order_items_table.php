<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('order_items', function (Blueprint $table) {
            $table->id();
            $table->integer('quantity')->default(0)->nullable(false);
            $table->string('tracking_number', 128)->nullable();
            $table->char('canceled')->nullable(false)->default('N');

            $table->foreignId('order_id')->nullable(true);
            $table->foreign('order_id')->on('orders')->references('id')
                ->onDelete('cascade')->cascadeOnUpdate();

            $table->foreignId('item_id');
            $table->foreign('item_id')->on('items')->references('id')
                ->onDelete('restrict')->cascadeOnUpdate();

            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('order_items');
    }
};
