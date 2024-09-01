<template>
  <div>
    <h2>Transfer Money</h2>
    <form @submit.prevent="transferMoney">
      <div>
        <label for="receiver-email">Receiver Email:</label>
        <input type="email" v-model="receiverEmail" required />
      </div>
      <div>
        <label for="amount">Amount:</label>
        <input type="number" v-model="amount" required min="0.01" step="0.01" />
      </div>
      <button type="submit">Transfer</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      receiverEmail: '',
      amount: ''
    };
  },
  methods: {
    async transferMoney() {
      try {
        const response = await axios.post('http://localhost:3000/transactions', {
          transaction: {
            receiver_email: this.receiverEmail,
            amount: Number(this.amount) // Ensure amount is a number
          },
          headers: {
            // Add headers if needed
            'X-CSRF-Token': this.$csrfToken // Optional, if CSRF protection is enabled
          }
        });
        alert(response.data.message);
      } catch (error) {
        alert(error.response?.data?.error || 'An error occurred'); // Handle undefined error response
      }
    }
  }
};
</script>
