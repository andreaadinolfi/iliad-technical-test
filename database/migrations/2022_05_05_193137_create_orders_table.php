<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->string('phone', 20)->nullable(true);
            $table->foreignId('shipping_status')->nullable(true);

            $table->foreign('shipping_status')->on('shipping_statuses')
                ->references('id')
                ->onDelete('restrict')->cascadeOnUpdate();

            $table->decimal('shipping_price', 10, 2)->default(0);
            $table->foreignId('shipping_payment_status')->nullable(true);
            $table->foreign('shipping_payment_status')->on('shipping_payment_statuses')
                ->references('id')
                ->onDelete('restrict')->cascadeOnUpdate();

            $table->foreignId('payment_status')->nullable(true);
            $table->foreign('payment_status')->on('payment_statuses')
                ->references('id')
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
        Schema::dropIfExists('orders');
    }
};
