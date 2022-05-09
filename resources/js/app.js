require('./bootstrap');

// import Alpine from 'alpinejs';
//
// window.Alpine = Alpine;
//
// Alpine.start();


require('alpinejs');

import { createApp } from 'vue';
import router from './router'

import OrdersIndex from './components/orders/OrdersIndex.vue';

createApp({
    components: {
        OrdersIndex
    }
}).use(router).mount('#app')
