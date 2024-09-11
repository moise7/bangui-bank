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
import { ref } from 'vue'; // Import ref from vue
import { useUserStore } from '@/stores/user'; // Import the Pinia store
import { useRouter } from 'vue-router'; // Import useRouter

export default {
  name: "Login",
  setup() {
    const userStore = useUserStore(); // Initialize the Pinia store
    const router = useRouter(); // Initialize the router

    // Define reactive state using ref
    const loginUsername = ref("");
    const loginPassword = ref("");
    const loginError = ref(null);

    // Handle login form submission
    const onLogin = async (event) => {
      event.preventDefault();
      const data = {
        username: loginUsername.value,
        password: loginPassword.value,
      };

      try {
        await userStore.loginUser(data);
        // Check if user is authenticated
        if (userStore.isAuthenticated) {
          // Ensure user data is available
          if (userStore.user && userStore.user.id) {
            router.push(`/dashboard/${userStore.user.id}`); // Redirect on success
          } else {
            loginError.value = "User data is not available.";
          }
        } else {
          loginError.value = "Login failed. Please check your username and password.";
        }
      } catch (error) {
        // Log the error and display a user-friendly message
        console.error('Login error:', error.response ? error.response.data : error.message);
        loginError.value = "There was an error logging in. Please try again.";
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



<style scoped>
.login {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

form {
  width: 100%;
  max-width: 400px;
}

input {
  width: 100%;
  padding: 10px;
  margin-bottom: 15px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

input[type="submit"] {
  background-color: #1a73e8;
  color: white;
  border: none;
  cursor: pointer;
  transition: background-color 0.3s;
}

input[type="submit"]:hover {
  background-color: #155aaf;
}

.text-red-500 {
  color: #f44336;
}

.text-blue-600 {
  color: #1a73e8;
}

a {
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}
</style>
