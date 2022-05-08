<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class OrderItem extends Model
{
    use SoftDeletes, HasFactory;

    protected $hidden = ['id','updated_at','created_at','deleted_at'];

    protected $dates = ['deleted_at'];

    public function item(){
        return $this->belongsTo(Item::class,'item_id');
    }

    public function order(){
        return $this->belongsTo(Order::class,'order_id');
    }

}
