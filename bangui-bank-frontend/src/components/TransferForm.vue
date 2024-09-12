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
      <button @click="goToDashboard" type="button">Go to Dashboard</button>
      <div v-if="error" class="error">{{ error }}</div>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import { ref } from 'vue'; // Import ref for reactive properties
import { useRouter } from 'vue-router';
import { useUserStore } from '@/stores/user'; // Import user store

export default {
  setup() {
    const router = useRouter();
    const userStore = useUserStore(); // Use the user store

    // Reactive properties
    const receiverEmail = ref('');
    const amount = ref('');
    const error = ref('');

    // Transfer money method
    const transferMoney = async () => {
      try {
        error.value = ''; // Reset error
        const response = await axios.post('http://localhost:3000/api/v1/transactions', {
          transaction: {
            receiver_email: receiverEmail.value,
            amount: Number(amount.value)
          }
        }, {
          headers: {
            Authorization: `Bearer ${userStore.token}` // Include token in the headers
          }
        });

        alert(response.data.message);

        // Redirect to the dashboard after a successful transfer
        router.push(`/dashboard/${userStore.userId}`);
      } catch (err) {
        error.value = err.response?.data?.error || 'An error occurred during the transfer';
      }
    };

    // Method to go to dashboard
    const goToDashboard = () => {
      router.push(`/dashboard/${userStore.userId}`);
    };

    // Return reactive properties and methods
    return {
      receiverEmail,
      amount,
      error,
      transferMoney,
      goToDashboard
    };
  }
};
</script>

<style>
.error {
  color: red;
}
</style>
