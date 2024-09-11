import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import { createPinia } from 'pinia'; // Import Pinia
import './index.css'

const app = createApp(App);
const pinia = createPinia(); // Create Pinia instance

app.use(router);
app.use(pinia); // Use Pinia instance
app.mount('#app');
