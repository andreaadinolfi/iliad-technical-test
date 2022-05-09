<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Order extends Model
{
    use SoftDeletes,HasFactory;

    protected $hidden = ['id','updated_at','created_at','deleted_at'];

    protected $guarded = [];

    protected $cascadeDeletes = ['order_items'];

    protected $dates = ['deleted_at'];

    public function orderItems()
    {
        return $this->hasMany(OrderItem::class);
    }

    public function shippingPaymentStatus()
    {
        return $this->belongsTo(ShippingPaymentStatus::class,'shipping_payment_status');
    }

    public function shippingStatus()
    {
        return $this->belongsTo(ShippingStatus::class,'shipping_status');
    }

    public function paymentStatus()
    {
        return $this->belongsTo(PaymentStatus::class,'payment_status');
    }

    protected static function boot()
    {
        parent::boot();

        static::deleted(function ($model) {
            $model->load([ 'orderItems']);

            $model->orderItems()->delete();
        });
    }
}
