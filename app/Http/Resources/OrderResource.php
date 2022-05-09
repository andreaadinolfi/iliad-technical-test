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
        return [
            'orderItems'=>OrderItemResource::collection($this->orderItems),
            "order_id" => $this->order_id,
            "phone" => $this->phone,
            "shipping_status" =>($this->shippingStatus) ? $this->shippingStatus->status : null,
            "shipping_price" => $this->shipping_price,
            "shipping_payment_status" => ($this->shippingPaymentStatus) ? $this->shippingPaymentStatus->status : null,
            "payment_status" => ($this->paymentStatus) ? $this->paymentStatus->status : null

        ];

    }
}
