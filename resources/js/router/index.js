import { createRouter, createWebHistory } from 'vue-router'

import OrdersIndex from '../components/orders/OrdersIndex.vue'

const routes = [
    {
        path: '/dashboard',
        name: 'orders.index',
        component: OrdersIndex
    }
];

export default createRouter({
    history: createWebHistory(),
    routes
})
