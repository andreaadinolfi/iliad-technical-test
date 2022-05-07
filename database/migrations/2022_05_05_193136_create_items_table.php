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
        Schema::create('items', function (Blueprint $table) {
            $table->id();
            $table->string('barcode',50)->unique()->nullable();
            $table->string('item_sid',50)->unique()->nullable();
            $table->tinyInteger('has_item_sid')->default(0);
            $table->decimal('price',10,2)->default(0);
            $table->decimal('cost',10,2)->default(0);
            $table->decimal('tax_perc',5,2)->default(0);
            $table->decimal('tax_amt',10,2)->default(0);

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
        Schema::dropIfExists('items');
    }
};
