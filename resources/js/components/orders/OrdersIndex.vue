<template>
    <div class="overflow-hidden overflow-x-auto min-w-full align-middle sm:rounded-md">
        <table class="min-w-full border divide-y divide-gray-200">
            <thead>
            <tr>
                <th class="px-6 py-3 bg-gray-50">
                    <span
                        class="text-xs font-medium tracking-wider leading-4 text-left text-gray-500 uppercase">Order id</span>
                </th>
                <th class="px-6 py-3 bg-gray-50">
                    <span
                        class="text-xs font-medium tracking-wider leading-4 text-left text-gray-500 uppercase">Phone</span>
                </th>
                <th class="px-6 py-3 bg-gray-50">
                    <span
                        class="text-xs font-medium tracking-wider leading-4 text-left text-gray-500 uppercase">Shipping Status</span>
                </th>
                <th class="px-6 py-3 bg-gray-50">
                    <span
                        class="text-xs font-medium tracking-wider leading-4 text-left text-gray-500 uppercase">Payment Status</span>
                </th>
                <th class="px-6 py-3 bg-gray-50">
                    <span
                        class="text-xs font-medium tracking-wider leading-4 text-left text-gray-500 uppercase">Date</span>
                </th>
                <th class="bg-gray-50"></th>

            </tr>
            </thead>

            <tbody class="bg-white divide-y divide-gray-200 divide-solid">
            <template v-for="item in orders" :key="item.order_id">
                <tr class="bg-white">
                    <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                        {{ item.order_id }}
                    </td>
                    <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                        {{ item.phone }}
                    </td>
                    <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                        {{ item.shipping_status }}
                    </td>
                    <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                        {{ item.payment_status }}
                    </td>
                    <td class="px-6 py-4 text-sm leading-5 text-gray-900 whitespace-no-wrap">
                        {{ item.date }}
                    </td>
                    <td class="px-6 py-4 text-sm text-center leading-5 text-gray-900 whitespace-no-wrap">
                        <button @click="deleteOrder(item.order_id)"
                                class="inline-flex items-center px-4 py-2 bg-gray-800 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 active:bg-gray-900 focus:outline-none focus:border-gray-900 focus:ring ring-gray-300 disabled:opacity-25 transition ease-in-out duration-150">
                            Delete</button>
                    </td>
                </tr>
            </template>
            </tbody>
        </table>
    </div>
</template>

<script>
import useOrders from '../../composables/orders'
import { onMounted } from 'vue';

export default {
    setup() {
        const { orders, getOrders,destroyOrder} = useOrders()

        const deleteOrder = async (id) => {
            if (!window.confirm('You sure?')) {
                return
            }

            await destroyOrder(id)
            await getOrders()
        }

        onMounted(getOrders)

        return {
            orders,
            deleteOrder
        }
    }
}
</script>
