<template>
  <div class="bg-gray-200 min-h-screen flex flex-col items-center justify-center p-4">
    <h3 class="text-2xl font-bold mb-4">Sign Up!</h3>
    <form @submit="onSignUp" class="w-full max-w-md">
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="signUpFirstName"
        placeholder="First Name"
        required
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="signUpMiddleName"
        placeholder="Middle Name"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="signUpLastName"
        placeholder="Last Name"
        required
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="date"
        v-model="signUpDateOfBirth"
        placeholder="Date of Birth"
        required
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="signUpTown"
        placeholder="Town"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="signUpCountry"
        placeholder="Country"
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="text"
        v-model="signUpUsername"
        placeholder="Username"
        required
      />
      <input
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        type="email"
        v-model="signUpEmail"
        placeholder="Email"
        required
      />
      <input
        type="password"
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        v-model="signUpPassword"
        placeholder="Password"
        required
      />
      <input
        type="password"
        class="w-full p-3 mb-3 border border-gray-300 rounded"
        v-model="signUpPasswordConfirmation"
        placeholder="Confirm Password"
        required
      />
      <input
        type="submit"
        value="Sign Up"
        class="w-full py-3 bg-blue-600 text-white rounded hover:bg-blue-500 cursor-pointer"
      />
    </form>
    <p class="text-orange-500 mt-4">You can update your details later in your profile</p>
    <a href="/login" class="text-blue-600 hover:underline mt-2">Already have an account?</a>
  </div>
</template>

<script>
import { ref } from 'vue';
import { useUserStore } from '@/stores/user'; // Import Pinia store
import { useRouter } from 'vue-router'; // Import useRouter

export default {
  name: 'SignUpForm',
  setup() {
    const userStore = useUserStore();
    const router = useRouter(); // Use router

    // Define reactive variables
    const signUpFirstName = ref("");
    const signUpMiddleName = ref("");
    const signUpLastName = ref("");
    const signUpDateOfBirth = ref("");
    const signUpTown = ref("");
    const signUpCountry = ref("");
    const signUpUsername = ref("");
    const signUpEmail = ref("");
    const signUpPassword = ref("");
    const signUpPasswordConfirmation = ref("");

    const onSignUp = async (event) => {
      event.preventDefault();

      const data = {
        user: {
          first_name: signUpFirstName.value,
          middle_name: signUpMiddleName.value,
          last_name: signUpLastName.value,
          date_of_birth: signUpDateOfBirth.value,
          town: signUpTown.value,
          country: signUpCountry.value,
          username: signUpUsername.value,
          email: signUpEmail.value,
          password: signUpPassword.value,
          password_confirmation: signUpPasswordConfirmation.value,
        },
      };

      try {
        await userStore.registerUser(data);
        resetData();

        // Check if the user is successfully logged in
        if (userStore.isAuthenticated) {
          // Redirect to the Dashboard
          if (userStore.user && userStore.user.id) {
            router.push(`/dashboard/${userStore.user.id}`);
          } else {
            loginError.value = "User data is not available.";
          } // Use router.push instead of this.$router.push
        } else {
          // Handle the case where signup did not result in a successful login
          alert('Signup failed. Please try again.');
        }
      } catch (error) {
        console.error('Signup error:', error);
        alert('There was an error signing up. Please try again.');
      }
    };

    const resetData = () => {
      signUpFirstName.value = '';
      signUpMiddleName.value = '';
      signUpLastName.value = '';
      signUpDateOfBirth.value = '';
      signUpTown.value = '';
      signUpCountry.value = '';
      signUpUsername.value = '';
      signUpEmail.value = '';
      signUpPassword.value = '';
      signUpPasswordConfirmation.value = '';
    };

    return {
      signUpFirstName,
      signUpMiddleName,
      signUpLastName,
      signUpDateOfBirth,
      signUpTown,
      signUpCountry,
      signUpUsername,
      signUpEmail,
      signUpPassword,
      signUpPasswordConfirmation,
      onSignUp,
      resetData,
    };
  },
};
</script>

