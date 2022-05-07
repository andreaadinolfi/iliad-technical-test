<?php

namespace Database\Factories;

use App\Models\Item;
use App\Models\Order;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\OrderItem>
 */
class OrderItemFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'quantity' => $this->faker->numberBetween(1, 3),
            'tracking_number' => strtoupper($this->faker->text(18)),
            'canceled' => $this->faker->randomElement(['Y', 'N']),
            'order_id' => Order::factory(),
            'item_id' => Item::factory(),
        ];
    }
}
