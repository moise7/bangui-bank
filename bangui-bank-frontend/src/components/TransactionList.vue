<template>
  <div>
    <h2>Your payments</h2>
    <ul>
      <li v-for="payment in payments" :key="payment.id">
        {{ payment.amount }} sent to {{ payment.receiver.email }} on {{ payment.created_at }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      payments: []
    };
  },
  async created() {
    const response = await axios.get('/payments');
    this.payments = response.data;
  }
};
</script>
