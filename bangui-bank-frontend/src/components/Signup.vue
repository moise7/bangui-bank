<template>
  <div class="signup bg-gray-200 min-h-screen flex flex-col items-center justify-center p-4">
    <h3 class="text-2xl font-bold mb-4">Sign Up!</h3>
    <form @submit="onSignUp" class="w-full max-w-md">
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="firstName"
        placeholder="First Name"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="middleName"
        placeholder="Middle Name"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="lastName"
        placeholder="Last Name"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="date"
        v-model="dateOfBirth"
        placeholder="Date of Birth"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="town"
        placeholder="Town"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="country"
        placeholder="Country"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="phoneNumber"
        placeholder="Phone Number"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="username"
        placeholder="Username"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="email"
        v-model="email"
        placeholder="Email"
      />
      <input
        type="password"
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        v-model="password"
        placeholder="Password"
      />
      <input
        type="password"
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        v-model="passwordConfirmation"
        placeholder="Confirm Password"
      />
      <input
        type="submit"
        value="Sign Up"
        class="w-full py-3 bg-blue-600 text-white rounded hover:bg-blue-500 cursor-pointer"
      />
    </form>
    <div v-if="signUpError" class="text-red-500 mt-4">
      {{ signUpError }}
    </div>
    <p class="text-blue-600 mt-4">
      <router-link to="/login">Already have an account? Login</router-link>
    </p>
  </div>
</template>

<script>
import { ref } from 'vue';
import { useUserStore } from '@/stores/user';
import { useRouter } from 'vue-router';

export default {
  name: "SignUp",
  setup() {
    const userStore = useUserStore();
    const router = useRouter();

    // Define reactive state
    const firstName = ref("");
    const middleName = ref("");
    const lastName = ref("");
    const dateOfBirth = ref("");
    const town = ref("");
    const country = ref("");
    const phoneNumber = ref("");
    const username = ref("");
    const email = ref("");
    const password = ref("");
    const passwordConfirmation = ref("");
    const signUpError = ref(null);

    // Handle sign-up form submission
    const onSignUp = async (event) => {
      event.preventDefault();
      const data = {
        user: {
          first_name: firstName.value,
          middle_name: middleName.value,
          last_name: lastName.value,
          date_of_birth: dateOfBirth.value,
          town: town.value,
          country: country.value,
          phone_number: phoneNumber.value,
          username: username.value,
          email: email.value,
          password: password.value,
          password_confirmation: passwordConfirmation.value,
        }
      };

      try {
        await userStore.signUpUser(data);
        console.log("Token:", userStore.token);
        if (userStore.isAuthenticated) {
          if (userStore.user && userStore.user.id) {
            router.push(`/dashboard/${userStore.user.id}`);
          } else {
            signUpError.value = "User data is not available.";
          }
        } else {
          alert('Signup failed. Please try again.');
        }
      } catch (error) {
        console.error('Sign-up error:', error.response ? error.response.data : error.message);
        signUpError.value = "There was an error signing up. Please try again.";
      }
    };


    return {
      firstName,
      middleName,
      lastName,
      dateOfBirth,
      town,
      country,
      phoneNumber,
      username,
      email,
      password,
      passwordConfirmation,
      signUpError,
      onSignUp,
    };
  },
};
</script>
