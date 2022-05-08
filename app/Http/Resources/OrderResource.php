<?php

namespace App\Http\Resources;

use App\Models\OrderItem;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Arr;

class OrderResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
//        return parent::toArray($request);

        $arr = parent::toArray($request);


        foreach ($arr['order_items'] as &$order_item){

            $has_item_sid = Arr::get($order_item, 'item.has_item_sid');
            $order_item['cost'] = Arr::get($order_item, 'item.cost');
            $order_item['price'] = Arr::get($order_item, 'item.cost');

            if($has_item_sid){
                $order_item['item_sid'] = Arr::get($order_item, 'item.item_sid');
            }else{
                $order_item['barcode'] = Arr::get($order_item, 'item.barcode');
            }
            unset($order_item['item']);

        }

        $ovride = [
            'shipping_payment_status' => ($this->shippingPaymentStatus) ? $this->shippingPaymentStatus->status : null,
            'shipping_status' => ($this->shippingStatus) ? $this->shippingStatus->status : null,
        ];

        return array_merge($arr,$ovride);

    }
}
