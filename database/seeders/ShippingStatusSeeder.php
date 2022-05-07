<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ShippingStatusSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('shipping_statuses')->insert([
            'id'=>'1',
            'status'=>'not send',
        ]);

        DB::table('shipping_statuses')->insert([
            'id'=>'2',
            'status'=>'send',
        ]);
    }
}
