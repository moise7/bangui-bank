<template>
  <div class="container">
      <h1 class="sm-title">Bangui Bank</h1>
      <div class="sm-card">
          <div v-if="isLoggedIn">
              <button @click="logoutUser" class="logout-button" >Logout</button>
              <table class="table">
                  <thead class="thead-dark">
                  <tr class="table-headers">
                      <th scope="col">ID</th>
                      <th scope="col">username</th>
                      <th scope="col">email</th>
                      <th scope="col">Token</th>
                  </tr>
                  </thead>
                  <tbody>
                  <tr class="table-rows">
                      <th class="table-row">[{{ this.getUserID }}]</th>
                      <td class="table-row table-row-username">{{ this.getUsername }}</td>
                      <td class="table-row">{{ this.getUserEmail }}</td>
                      <td class="table-row">{{ this.getAuthToken }}</td>
                  </tr>
                  </tbody>
              </table>
          </div>
          <div v-else>
              <h3>Sign Up!</h3>
                <form @submit="onSignUp" class="sign-up-form">
                <input
                    class="sign-up-form-username"
                    type="text"
                    v-model="signUpUsername"
                    placeholder="Username"
                />
                <br />
                <input
                    class="sign-up-form-email"
                    type="email"
                    v-model="signUpEmail"
                    placeholder="Email"
                />
                <br />
                <input
                    type="password"
                    class="sign-up-form-password"
                    v-model="signUpPassword"
                    placeholder="Password"
                />
                <br />
                <input type="submit" value="Sign up" class="sign-up-form-submit" />
                </form>
                <hr />
                <br />
              <h3>Login!</h3>
              <form @submit="onLogin" class="login-form">
                <input
                    class="login-form-username"
                    type="text"
                    v-model="loginUsername"
                    placeholder="Username"
                />
                <br />
                <input
                    type="password"
                    class="login-form-password"
                    v-model="loginPassword"
                    placeholder="Password"
                />
                <br />
                  <input type="submit" value="Login" class="login-form-submit" />
              </form>
          </div>
      </div>
  </div>
</template>

<script>
import "@/stores/index.js";
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
      ...mapActions(["signUpUser", "loginUser", "logoutUser"]),
      onSignUp(event) {
          event.preventDefault();
          let data = {
          user: {
          username: this.signUpUsername,
          email: this.signUpEmail,
          password: this.signUpPassword,
          },
      };
      this.signUpUser(data);
      this.resetData();
      },
      onLogin(event) {
          event.preventDefault();
          let data = {
              user: {
                  username: this.loginUsername,
                //   email: this.loginEmail,
                  password: this.loginPassword,
              },
          };
          this.loginUser(data);
          this.resetData();
      },
      resetData() {
          this.signUpUsername = "";
          this.signUpEmail = "";
          this.signUpPassword = "";
          this.loginUsername = "";
          this.loginEmail = "";
          this.loginPassword = "";
      },
  },
}
</script>

<style scoped>
.sm-title {
font-size: 2.5rem;
font-weight: bold;
text-align: center;
font-family: "Roboto", sans-serif;
}
.container {
width: 90%;
margin: 0 auto;
}
.sm-card {
width: 75%;
padding: 20px;
margin: 0 auto;
height: 25em;
border-radius: 10px;
box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.2);
}
.sign-up-form {
width: 100%;
}
.sign-up-form-email, .sign-up-form-username {
width: 55%;
padding: 10px;
margin: 0 auto;
border-radius: 5px;
border: 1px solid #ccc;
}
.sign-up-form-password {
width: 55%;
padding: 10px;
margin: 0 auto;
border-radius: 5px;
border: 1px solid #ccc;
}
.sign-up-form-submit {
width: 15%;
padding: 1em;
margin: 0 auto;
border-radius: 5px;
background-color: #1a77ce;
color: #fff;
border: none;
}
.sign-up-form-submit:hover {
background-color: #0d5c8a;
cursor: pointer;
}

.login-form {
width: 100%;
}
.login-form-email {
width: 55%;
padding: 10px;
margin: 0 auto;
border-radius: 5px;
border: 1px solid #ccc;
}
.login-form-password {
width: 55%;
padding: 10px;
margin: 0 auto;
border-radius: 5px;
border: 1px solid #ccc;
}
.login-form-submit {
width: 15%;
padding: 1em;
margin: 0 auto;
border-radius: 5px;
background-color: #1a77ce;
color: #fff;
border: none;
}
.login-form-submit:hover {
background-color: #0d5c8a;
cursor: pointer;
}
.logout-button {
width: 15%;
padding: 1em;
margin: 0 auto;
border-radius: 5px;
background-color: #1a77ce;
color: #fff;
border: none;
}
.logout-button:hover {
background-color: #0d5c8a;
cursor: pointer;
}
.table-headers {
background-color: #2b3b49;
color: #fff;
max-width: 90%;
margin: 0 auto;
}
.table-rows {
background-color: #f2f2f2;
margin: 0 auto;
}
.table-row {
word-break: break-all;
text-align: center;
padding: 10px;
}
.table-row-username {
width: 30%;
}
</style>

<style scoped>
html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}
.home {
  text-align: center;
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
