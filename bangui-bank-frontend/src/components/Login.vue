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
import { mapActions, mapGetters } from "vuex";

export default {
  name: "Login",
  data() {
    return {
      loginUsername: "",
      loginPassword: "",
      loginError: null,
    };
  },
  computed: {
    ...mapGetters(["isLoggedIn"]),
  },
  methods: {
    ...mapActions(["loginUser"]),
    async onLogin(event) {
      event.preventDefault();
      const data = {
        username: this.loginUsername, // Use username here
        password: this.loginPassword,
      };

      try {
        const response = await this.loginUser(data);

        if (response.status === 200) {
          this.$router.push("/dashboard"); // Redirect on success
        } else {
          this.loginError = "Login failed. Please check your username and password.";
        }
      } catch (error) {
        this.loginError = "There was an error logging in. Please try again.";
      }
    },
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
