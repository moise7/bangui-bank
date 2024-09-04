<template>
  <div class="login bg-gray-200 min-h-screen flex flex-col items-center justify-center p-4">
    <h3 class="text-2xl font-bold mb-4">Login!</h3>
    <form @submit="onLogin" class="w-full max-w-md">
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="loginUsername"
        placeholder="Username"
      />
      <input
        type="password"
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        v-model="loginPassword"
        placeholder="Password"
      />
      <input
        type="submit"
        value="Login"
        class="w-full py-3 bg-blue-600 text-white rounded hover:bg-blue-500 cursor-pointer"
      />
    </form>
    <div v-if="loginError" class="text-red-500 mt-4">
      {{ loginError }}
    </div>
    <p class="text-blue-600 mt-4">
      <router-link to="/signup">Don't have an account? Sign up</router-link>
    </p>
  </div>
</template>

<script>
import { useRouter } from 'vue-router';
import { useUserStore } from '@/stores/user'; // Adjust the path as necessary

export default {
  name: 'Login',
  data() {
    return {
      loginUsername: '',
      loginPassword: '',
      loginError: '',
    };
  },
  setup() {
    const router = useRouter();
    const userStore = useUserStore();

    const onLogin = async (event) => {
      event.preventDefault();
      loginError.value = ''; // Clear previous errors

      const data = {
        user: {
          username: loginUsername.value,
          password: loginPassword.value,
        },
      };

      try {
        // Call the loginUser action and wait for it to complete
        await userStore.loginUser(data);

        // Redirect to the dashboard on successful login
        if (userStore.isAuthenticated) {
          router.push('/dashboard'); // Adjust the path as needed
        } else {
          loginError.value = 'Login failed. Please check your credentials and try again.';
        }
      } catch (error) {
        console.error('Login failed:', error);
        loginError.value = 'An error occurred during login. Please try again.';
      }

      resetData();
    };

    const resetData = () => {
      loginUsername.value = '';
      loginPassword.value = '';
    };

    return {
      loginUsername,
      loginPassword,
      loginError,
      onLogin,
      resetData,
    };
  },
};
</script>

<style scoped>
/* Add styles specific to login form */
.error-message {
  color: red;
  margin-top: 10px;
}
</style>
