<template>
  <div class="relative min-h-screen bg-gray-100 p-4 font-mona">
    <!-- Initial Loading Screen -->
    <div v-if="loading" class="fixed inset-0 bg-gray-800 bg-opacity-75 flex items-center justify-center z-50">
      <div class="text-white text-lg" aria-live="assertive">{{ loadingMessage }}</div>
    </div>

    <!-- Success Message Notification -->
    <div v-if="showSuccessNotification" class="fixed bottom-4 right-4 bg-green-500 text-white px-4 py-2 rounded-lg shadow-lg transform translate-y-10 transition-transform duration-300 ease-in-out z-40" aria-live="polite">
      <div class="flex items-center justify-between">
        <span>{{ successNotificationMessage }}</span>
        <button class="ml-4 p-1 text-white hover:text-gray-200" @click="showSuccessNotification = false" aria-label="Close notification">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M4.293 5.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </button>
      </div>
    </div>

    <!-- Form -->
    <div class="flex flex-col items-center justify-center">
      <form @submit.prevent="makePayment" class="bg-white shadow-md rounded-lg p-8 w-full max-w-md">
        <div class="mb-4">
          <label for="receiver-email" class="block text-sm font-medium text-gray-700 mb-1">Email du destinataire :</label>
          <input type="email" v-model="receiverEmail" required
                class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Entrez l'email du destinataire" aria-label="Email du destinataire" />
        </div>
        <div class="mb-4">
          <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description :</label>
          <input type="text" v-model="description" required
                class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Entrez la description du paiement" aria-label="Description" />
        </div>
        <div class="mb-6">
          <label for="amount" class="block text-sm font-medium text-gray-700 mb-1">Montant :</label>
          <input type="number" v-model="amount" required min="0.01" step="0.01"
                class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Entrez le montant" aria-label="Montant" />
        </div>
        <div class="flex justify-between">
          <button type="submit"
                  class="inline-flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-200 ease-in-out">
            Effectuer le paiement
          </button>
          <button @click="goToDashboard" type="button"
                  class="inline-flex justify-center py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition duration-200 ease-in-out">
            Aller au tableau de bord
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
    const description = ref('');
    const error = ref('');
    const loadingMessage = ref('Traitement en cours...');
    const successNotificationMessage = ref('');
    const loading = ref(false);
    const showSuccessNotification = ref(false);

    const makePayment = async () => {
      try {
        loading.value = true;
        error.value = '';
        successNotificationMessage.value = '';
        showSuccessNotification.value = false;

        const response = await axios.post('http://localhost:3000/api/v1/payments', {
          payment: {
            receiver_email: receiverEmail.value,
            amount: Number(amount.value),
            description: description.value
          }
        }, {
          headers: {
            Authorization: `Bearer ${userStore.token}`
          }
        });

        successNotificationMessage.value = 'Paiement complété, redirection vers le tableau de bord...';

        setTimeout(() => {
          showSuccessNotification.value = true;
          setTimeout(() => {
            router.push(`/dashboard/${userStore.userId}`);
          }, 100);
        }, 900);

      } catch (err) {
        error.value = err.response?.data?.error || 'Une erreur est survenue lors du paiement';
      } finally {
        loading.value = false;
      }
    };

    const goToDashboard = () => {
      router.push(`/dashboard/${userStore.userId}`);
    };

    return {
      receiverEmail,
      amount,
      description,
      error,
      loadingMessage,
      successNotificationMessage,
      loading,
      showSuccessNotification,
      makePayment,
      goToDashboard
    };
  }
};
</script>
