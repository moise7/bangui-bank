<template>
  <div class="bg-gray-200 min-h-screen flex flex-col items-center justify-center p-4">
    <h3 class="text-2xl font-bold mb-4">Sign Up!</h3>
    <form @submit="onSignUp" class="w-full max-w-md">
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="signUpUsername"
        placeholder="Username"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="email"
        v-model="signUpEmail"
        placeholder="Email"
      />
      <input
        type="password"
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        v-model="signUpPassword"
        placeholder="Password"
      />
      <input
        type="submit"
        value="Sign up"
        class="w-full py-3 bg-blue-600 text-white rounded hover:bg-blue-500 cursor-pointer"
      />
    </form>
    <p class="text-orange-500 mt-4">You can change your preferred name later in your profile</p>
    <a href="/login" class="text-blue-600 hover:underline mt-2">Already have an account?</a>
  </div>
</template>

<script>
import "@/store/index.js";
import { mapActions, mapGetters } from "vuex";
export default {
  name: "SessionManager",
  computed: {
      ...mapGetters(["getAuthToken", "getUserEmail", "getUsername", "getUserID", "isLoggedIn"]),
  },
  data() {
      return {
      signUpUsername: "",
      signUpEmail: "",
      signUpPassword: "",
      loginUsername: "",
      loginPassword: "",
      };
  },
  methods: {
  ...mapActions(["registerUser", "loginUser", "logoutUser"]),
  async onSignUp(event) {
    event.preventDefault();
    let data = {
      user: {
        username: this.signUpUsername,
        email: this.signUpEmail,
        password: this.signUpPassword,
      },
    };

    try {
      await this.registerUser(data);
      this.resetData();

      // Check if the user is successfully logged in (if the login state changes after signup)
      if (this.isLoggedIn) {
        // Redirect to the Dashboard
        this.$router.push('/dashboard');
      } else {
        // Handle the case where signup did not result in a successful login
        alert('Signup failed. Please try again.');
      }
    } catch (error) {
      console.error('Signup error:', error);
      alert('There was an error signing up. Please try again.');
    }
  },
  resetData() {
    this.signUpUsername = "";
    this.signUpEmail = "";
    this.signUpPassword = "";
    this.loginUsername = "";
    this.loginEmail = "";
    this.loginPassword = "";
  },
}
}
</script>
