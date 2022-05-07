<?php

namespace Database\Seeders;

use App\Models\Item;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call(ShippingStatusSeeder::class);
        $this->call(ShippingPaymentStatusSeeder::class);

        Order::factory(20)->has(
            OrderItem::factory(2)->has(
                Item::factory(1)
            )
        )->create();

    }
}
