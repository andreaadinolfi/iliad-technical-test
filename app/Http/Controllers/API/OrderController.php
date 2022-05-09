<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\OrderResource;
use App\Models\Order;
use DateInterval;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Symfony\Component\Routing\Exception\MethodNotAllowedException;
use Throwable;

class OrderController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(){
        $data = Order::with(['orderItems','shippingPaymentStatus','shippingStatus','paymentStatus'])->latest()->get();
        return response()->json([OrderResource::collection($data), 'orders fetched.']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'name' => 'required|string|max:255',
            'desc' => 'required'
        ]);

        if($validator->fails()){
            return response()->json($validator->errors());
        }

        $order = Order::create([
            'name' => $request->name,
            'desc' => $request->desc
        ]);

        return response()->json(['Order created successfully.', new Order($order)]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($order_id)
    {

        $order = Order::with(['orderItems.item','shippingPaymentStatus','shippingStatus','paymentStatus'])
            ->where('order_id',$order_id)->first();

        if (is_null($order)) {
            return response()->json('Data not found', 404);
        }
        return response()->json([new OrderResource($order)]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $order_id)
    {
        $order = Order::with(['orderItems.item','shippingPaymentStatus','shippingStatus','paymentStatus'])
            ->where('order_id',$order_id)->first();

        $validator = Validator::make($request->all(),[
            'phone' => 'string|max:20',
            'shipping_status' =>'integer', Rule::in(['1', '2']),
            'shipping_payment_status' => Rule::in(['1', '2']),
            'shipping_price' =>'numeric|gte:0',
        ]);

        if($validator->fails()){
            return response()->json($validator->errors());
        }

//        if ($request->has('phone')){
//            $order->phone = $request->phone;
//        }
        $order->phone = $request->phone;

        $order->shipping_status = $request->shipping_status;
        $order->shipping_price = $request->shipping_price;

        $order->save();

        $order->refresh();
        return response()->json(['order updated successfully.', new OrderResource($order)]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Order $order)
    {
        $order->delete();
        return response()->json('Order deleted successfully');
    }

    public function orders_search(Request $request){

        try {
            if(!$request->isMethod('POST')){
                throw new MethodNotAllowedException('POST');
            }

            if ($request->has('count')) {

                $count = (int)$request->post('count');
                $count = ($count <= 0) ? 1 : $count;
                $count = ($count > 20) ? 20 : $count;

                $data = Order::with(['orderItems.item', 'shippingPaymentStatus', 'shippingStatus','paymentStatus'])
                    ->orderBy('created_at', 'ASC')
                    ->get()->take($count);
                return OrderResource::collection($data);
            }

            $data = Order::with(['orderItems.item', 'shippingPaymentStatus', 'shippingStatus','paymentStatus'])
                ->orderBy('created_at', 'DESC')->get();

            if ($request->has('date_from')) {

                $date_from = $request->post('date_from');
                $date_from = DateTime::createFromFormat('Ymd', $date_from);
                $data = $data->where('created_at', '>=', $date_from->format('Y-m-d'));

            }

            if ($request->has('date_to')) {

                $date_to = $request->get('date_to');
                $date_to = DateTime::createFromFormat('Ymd', $date_to);
                $date_to = $date_to->add(new DateInterval('P1D'));

                $data = $data->where('created_at', '<', $date_to->format('Y-m-d'));

            }

        }catch (MethodNotAllowedException $e){
            return response()->json( ['message'=>$e->getMessage()], 400);

        } catch (Throwable $e) {
            return response()->json( ['message'=>$e->getMessage()], 500);
        }

        return response()->json([OrderResource::collection($data), sprintf('%d orders fetched.',$data->count())]);
    }
}
