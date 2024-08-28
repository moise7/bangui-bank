<template>
  <div class="home">
    <b-nav bg-secondary>
      <router-link to="/login" class="nav-link">Log In</router-link>
      <router-link to="/signup" class="nav-link">Sign Up</router-link>
    </b-nav>
    <div class="content">
      <h1>Online Banking for Central Africa Republic</h1>
      <div class="signup-form">
        <input v-model="email" type="email" placeholder="Enter your email" />
        <button @click="signUp">Sign Up</button>
      </div>
      <p class="account-info">Already have an account?</p>
    </div>
    <div class="footer">
      <span>Online Banking</span>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

export default {
  name: 'Home',
  setup() {
    const email = ref('')
    const router = useRouter()

    const signUp = async () => {
      console.log("Sign up with email:", email.value)
      // Implement actual signup logic here
    }

    return {
      email,
      signUp
    }
  }
}
</script>

<style scoped>
html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}
.home {
  text-align: center;
  background-color: #00a300;
  color: white;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.custom-nav {
  background-color: white !important; /* Override Bootstrap default background */
  padding: 1em;
}

.custom-nav .nav-link {
  color: black !important; /* Override Bootstrap default text color */
  margin: 0 1em;
  text-decoration: none;
  font-weight: bold;
}

.custom-nav .nav-link:hover {
  color: #007bff; /* Optional: Change hover color if desired */
}

.content {
  padding: 2em;
  flex-grow: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

h1 {
  font-size: 2.5em;
  margin-bottom: 1em;
}

.signup-form {
  display: flex;
  justify-content: center;
  margin-bottom: 1em;
}

.signup-form input {
  padding: 0.5em;
  font-size: 1em;
  margin-right: 1em;
  border: none;
  border-radius: 4px;
}

.signup-form button {
  padding: 0.5em 1em;
  font-size: 1em;
  background-color: white;
  color: #00a300;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

.signup-form button:hover {
  background-color: #e6e6e6;
}

.account-info {
  font-size: 1em;
}

.footer {
  padding: 1em;
  background-color: #008000;
  font-size: 0.8em;
  color: #d9d9d9;
}
</style>
