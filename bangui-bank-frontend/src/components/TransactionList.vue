<template>
  <div>
    <h2>Your Transactions</h2>
    <ul>
      <li v-for="transaction in transactions" :key="transaction.id">
        {{ transaction.amount }} sent to {{ transaction.receiver.email }} on {{ transaction.created_at }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      transactions: []
    };
  },
  async created() {
    const response = await axios.get('/transactions');
    this.transactions = response.data;
  }
};
</script>
