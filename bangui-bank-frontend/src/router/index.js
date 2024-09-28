// src/router/index.js
import { createRouter, createWebHistory } from 'vue-router';
import Home from '../components/Home.vue';
import Login from '../components/Login.vue';
import Signup from '../components/Signup.vue';
import Dashboard from '../components/Dashboard.vue';
import PaymentForm from '../components/PaymentForm.vue'; // Import the SendMoney component

const routes = [
  { path: '/', component: Home },
  { path: '/login', component: Login },
  { path: '/signup', component: Signup },
  { path: '/dashboard/:userId', component: Dashboard }, // Fixed the dynamic userId param
  { path: '/payment-form', component: PaymentForm }, // Route for Send Money
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
