<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class OrderItemResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param \Illuminate\Http\Request $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {

        if($this->item->has_item_sid){
            $bar_or_sid = 'item_sid';
        }else{
            $bar_or_sid = 'barcode';
        }

        return [
            $bar_or_sid =>  $this->item->{$bar_or_sid},
            "price" => $this->item->price,
            "cost" => $this->item->cost,
            "tax_perc" => $this->item->tax_perc,
            "tax_amt" => $this->item->tax_amt,
            "quantity" => $this->quantity,
            "tracking_number" => $this->tracking_number,
            "canceled" => $this->canceled,
            "shipped_status_sku" => ($this->order->shippingStatus) ? $this->order->shippingStatus->status : null,
        ];

    }
}
