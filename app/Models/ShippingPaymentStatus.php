<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShippingPaymentStatus extends Model
{
    use HasFactory;

    protected $table = 'shipping_payment_statuses';

//    public function orders(){
//        return $this->hasMany(Order::class);
//    }
}
