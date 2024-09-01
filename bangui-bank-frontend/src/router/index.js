// src/router/index.js
import { createRouter, createWebHistory } from 'vue-router';
import Home from '../components/Home.vue';
import Login from '../components/Login.vue';
import Signup from '../components/Signup.vue';
import Dashboard from '../components/Dashboard.vue';
import TransferForm from '../components/TransferForm.vue'; // Import the SendMoney component

const routes = [
  { path: '/', component: Home },
  { path: '/login', component: Login },
  { path: '/signup', component: Signup },
  { path: '/dashboard', component: Dashboard },
  { path: '/transfer-form', component: TransferForm }, // Add the route for Send Money
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
