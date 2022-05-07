<?php

namespace Database\Factories;

use App\Models\ShippingPaymentStatus;
use App\Models\ShippingStatus;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Order>
 */
class OrderFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'phone' => $this->faker->e164PhoneNumber(),
            'order_id' => strtoupper(Str::random(12)),
            'shipping_price' => $this->faker->randomNumber(3),
            'shipping_status' => $this->faker->numberBetween(1,2),
            'shipping_payment_status' => $this->faker->numberBetween(1,2),
        ];
    }
}
