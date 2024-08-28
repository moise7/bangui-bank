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
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import { useRouter } from "vue-router";

export default {
  name: 'Login',
  data() {
    return {
      loginUsername: '',
      loginPassword: '',
      loginError: '', // Add a data property for handling login errors
    };
  },
  computed: {
    ...mapGetters(["getAuthToken", "getUserEmail", "getUsername", "getUserID", "isLoggedIn"]),
  },
  methods: {
    ...mapActions(["loginUser"]),

    async onLogin(event) {
      event.preventDefault();
      this.loginError = ''; // Clear previous errors

      let data = {
        user: {
          username: this.loginUsername,
          password: this.loginPassword,
        },
      };

      try {
        // Call the loginUser action and wait for it to complete
        await this.loginUser(data);

        // Redirect to the dashboard on successful login
        if (this.isLoggedIn) {
          this.$router.push('/dashboard'); // Adjust the path as needed
        } else {
          this.loginError = 'Login failed. Please check your credentials and try again.';
        }
      } catch (error) {
        console.error('Login failed:', error);
        this.loginError = 'An error occurred during login. Please try again.';
      }

      this.resetData();
    },

    resetData() {
      this.loginUsername = '';
      this.loginPassword = '';
    },
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
