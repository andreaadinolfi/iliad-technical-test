<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Item>
 */
class ItemFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        $has_item_sid = $this->faker->boolean();
        $cost = $this->faker->randomNumber(4);
        $created = $this->faker->dateTimeThisMonth()->format('Y-m-d H:i:s');
        return [
            'barcode' => (!$has_item_sid) ? $this->faker->ean13() : null,
            'has_item_sid' => $has_item_sid,
            'item_sid' => ($has_item_sid) ? $this->faker->ean13() : null,
            'price' => $cost,
            'cost' => $cost,
            'tax_perc' =>  $this->faker->randomNumber(2),
            'tax_amt' => $this->faker->randomNumber(4),
            'created_at' => $created,
            'updated_at' => $created,
        ];
    }
}
