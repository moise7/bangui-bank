<template>
  <div class="login bg-gray-100 min-h-screen flex flex-col items-center justify-center py-8 px-4 font-mona">
    <h3 class="text-3xl font-extrabold text-gray-700 mb-6">Content de vous revoir !</h3>
    <form @submit="onLogin" class="w-full max-w-md shadow-md rounded-lg bg-white p-6">
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-300"
        type="text"
        v-model="loginUsername"
        placeholder="Nom d'utilisateur"
      />
      <input
        type="password"
        class="w-full p-3 mb-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-300"
        v-model="loginPassword"
        placeholder="Mot de passe"
      />
      <input
        type="submit"
        value="Se connecter"
        class="w-full py-3 bg-yellow-500 text-white rounded-lg hover:bg-yellow-600 transition-colors duration-300 cursor-pointer"
      />
    </form>
    <div v-if="loginError" class="text-red-500 mt-4">
      {{ loginError }}
    </div>
    <p class="text-gray-600 mt-6">
      Vous n'avez pas de compte ?
      <router-link
        to="/signup"
        class="text-yellow-500 font-semibold hover:underline hover:text-yellow-600 transition-colors duration-300"
      >
        Inscrivez-vous
      </router-link>
    </p>
  </div>
</template>

<script>
import { ref } from 'vue';
import { useUserStore } from '@/stores/user';
import { useRouter } from 'vue-router';

export default {
  name: "Login",
  setup() {
    const userStore = useUserStore();
    const router = useRouter();

    const loginUsername = ref("");
    const loginPassword = ref("");
    const loginError = ref(null);

    const onLogin = async (event) => {
      event.preventDefault();
      const data = {
        username: loginUsername.value,
        password: loginPassword.value,
      };

      try {
        await userStore.loginUser(data);
        if (userStore.isAuthenticated) {
          if (userStore.user && userStore.user.id) {
            router.push(`/dashboard/${userStore.user.id}`);
          } else {
            loginError.value = "Les données utilisateur ne sont pas disponibles.";
          }
        } else {
          loginError.value = "Échec de connexion. Veuillez vérifier votre nom d'utilisateur et votre mot de passe.";
        }
      } catch (error) {
        console.error('Erreur de connexion:', error.response ? error.response.data : error.message);
        loginError.value = "Une erreur est survenue lors de la connexion. Veuillez réessayer.";
      }
    };

    return {
      loginUsername,
      loginPassword,
      loginError,
      onLogin,
    };
  },
};
</script>

