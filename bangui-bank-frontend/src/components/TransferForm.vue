<template>
  <div class="relative min-h-screen bg-gray-100 p-4">
    <!-- Initial Loading Screen -->
    <div v-if="loading" class="fixed inset-0 bg-gray-800 bg-opacity-75 flex items-center justify-center z-50">
      <div class="text-white text-lg">{{ loadingMessage }}</div>
    </div>

    <!-- Success Message Loading Screen -->
    <div v-if="successLoading" class="fixed inset-0 bg-gray-800 bg-opacity-75 flex items-center justify-center z-50">
      <div class="text-white text-lg">{{ successMessage }}</div>
    </div>

    <!-- Success Message Notification -->
    <div v-if="showSuccessNotification" class="fixed bottom-4 right-4 bg-green-500 text-white px-4 py-2 rounded-lg shadow-lg transform translate-y-10 transition-transform duration-300 ease-in-out z-40">
      <div class="flex items-center justify-between">
        <span>{{ successNotificationMessage }}</span>
        <button class="ml-4 p-1 text-white hover:text-gray-200" @click="showSuccessNotification = false">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M4.293 5.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </button>
      </div>
    </div>

    <!-- Form -->
    <div class="flex flex-col items-center justify-center">
      <form @submit.prevent="transferMoney" class="bg-white shadow-md rounded-lg p-8 w-full max-w-md">
        <div class="mb-4">
          <label for="receiver-email" class="block text-sm font-medium text-gray-700 mb-1">Receiver Email:</label>
          <input type="email" v-model="receiverEmail" required
                class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Enter receiver's email" />
        </div>
        <div class="mb-6">
          <label for="amount" class="block text-sm font-medium text-gray-700 mb-1">Amount:</label>
          <input type="number" v-model="amount" required min="0.01" step="0.01"
                class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Enter amount" />
        </div>
        <div class="flex justify-between">
          <button type="submit"
                  class="inline-flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-200 ease-in-out">
            Transfer
          </button>
          <button @click="goToDashboard" type="button"
                  class="inline-flex justify-center py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition duration-200 ease-in-out">
            Go to Dashboard
          </button>
        </div>
        <div v-if="error" class="mt-4 text-red-600 text-sm">{{ error }}</div>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useUserStore } from '@/stores/user';

export default {
  setup() {
    const router = useRouter();
    const userStore = useUserStore();
    const receiverEmail = ref('');
    const amount = ref('');
    const error = ref('');
    const loadingMessage = ref('Processing...');
    const successMessage = ref('Transaction successful. Redirecting to dashboard...');
    const successNotificationMessage = ref('');
    const loading = ref(false);
    const successLoading = ref(false);
    const showSuccessNotification = ref(false);

    const transferMoney = async () => {
      try {
        loading.value = true;
        error.value = '';
        successNotificationMessage.value = '';
        successLoading.value = false;
        showSuccessNotification.value = false;

        const response = await axios.post('http://localhost:3000/api/v1/transactions', {
          transaction: {
            receiver_email: receiverEmail.value,
            amount: Number(amount.value)
          }
        }, {
          headers: {
            Authorization: `Bearer ${userStore.token}`
          }
        });

        // Hide initial loading screen and show success loading message
        loading.value = false;
        successLoading.value = true;

        // Show the success notification and then redirect after a delay
        setTimeout(() => {
          successLoading.value = false;
          showSuccessNotification.value = true;
          setTimeout(() => {
            router.push(`/dashboard/${userStore.userId}`);
          }, 100); // Adjust this delay if needed
        }, 900); // Adjust this delay if needed

      } catch (err) {
        loading.value = false;
        error.value = err.response?.data?.error || 'An error occurred during the transfer';
      }
    };

    const goToDashboard = () => {
      router.push(`/dashboard/${userStore.userId}`);
    };

    return {
      receiverEmail,
      amount,
      error,
      loadingMessage,
      successMessage,
      successNotificationMessage,
      loading,
      successLoading,
      showSuccessNotification,
      transferMoney,
      goToDashboard
    };
  }
};
</script>
