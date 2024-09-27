<template>
  <div class="signup bg-gray-200 min-h-screen flex flex-col items-center justify-center p-4">
    <h3 class="text-2xl font-bold mb-6">Sign Up!</h3>
    <form @submit="onSignUp" class="w-full max-w-md bg-white p-6 rounded-lg shadow-md">
      <!-- First Name -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="text"
        v-model="firstName"
        placeholder="First Name"
      />

      <!-- Middle Name -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="text"
        v-model="middleName"
        placeholder="Middle Name"
      />

      <!-- Last Name -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="text"
        v-model="lastName"
        placeholder="Last Name"
      />

      <!-- Date of Birth -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="date"
        v-model="dateOfBirth"
        placeholder="Date of Birth"
      />

      <!-- Country Dropdown -->
      <select
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        v-model="country"
      >
        <option disabled value="">Select Country</option>
        <option value="Central Africa Republic">Central Africa Republic</option>
        <option value="Other Country">Other Country</option>
      </select>

      <!-- Town Dropdown (if Central Africa Republic is selected) -->
      <div v-if="country === 'Central Africa Republic'">
        <select
          class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
          v-model="town"
        >
          <option disabled value="">Select Town</option>
          <option v-for="townItem in towns" :key="townItem" :value="townItem">
            {{ townItem }}
          </option>
        </select>
      </div>

      <!-- Phone Number -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="text"
        v-model="phoneNumber"
        placeholder="Phone Number"
      />

      <!-- Username -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="text"
        v-model="username"
        placeholder="Username"
      />

      <!-- Email -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="email"
        v-model="email"
        placeholder="Email"
      />

      <!-- Password -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="password"
        v-model="password"
        placeholder="Password"
      />

      <!-- Confirm Password -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="password"
        v-model="passwordConfirmation"
        placeholder="Confirm Password"
      />

      <!-- Submit Button -->
      <button
        type="submit"
        class="w-full py-3 bg-blue-600 text-white rounded-lg font-semibold text-lg shadow-md hover:bg-blue-500 focus:outline-none focus:ring-4 focus:ring-blue-300 transition duration-300"
      >
        S'inscrire
      </button>
    </form>

    <!-- Error Message -->
    <div v-if="signUpError" class="text-red-500 mt-4">
      {{ signUpError }}
    </div>

    <!-- Link to Login -->
    <p class="text-gray-600 mt-4">
      Already have an account?
      <router-link
        to="/login"
        class="text-blue-600 font-semibold hover:underline hover:text-blue-500 transition-colors duration-300"
      >
        Login
      </router-link>
    </p>

  </div>
</template>

<script>
import { ref, onMounted, watch } from 'vue';
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

    // Fetch towns from Pinia store on component mount
    onMounted(() => {
      if (!userStore.towns.length) {
        userStore.fetchTowns();
        console.log("FetchTowns", userStore.fetchTowns())
      }
    });

    // Watch for changes in the selected country to reset town selection
    watch(country, (newCountry) => {
      if (newCountry !== 'Central Africa Republic') {
        town.value = "";
      }
    });

    // Handle sign-up form submission
    const onSignUp = async (event) => {
      event.preventDefault();
      const data = {
        user: {
          first_name: firstName.value,
          middle_name: middleName.value,
          last_name: lastName.value,
          date_of_birth: dateOfBirth.value,
          town: town.value, // Selected town
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
      town, // Bind the selected town
      towns: userStore.towns, // Use towns from Pinia store
      country, // Bind country
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
