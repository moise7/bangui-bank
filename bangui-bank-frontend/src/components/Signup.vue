<template>
  <div class="signup bg-gray-200 min-h-screen flex flex-col items-center justify-center p-4">
    <h3 class="text-2xl font-bold mb-6">Inscription</h3>
    <form @submit="onSignUp" class="w-full max-w-md bg-white p-6 rounded-lg shadow-md">
      <!-- First Name -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="text"
        v-model="firstName"
        placeholder="Prénom"
      />

      <!-- Middle Name -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="text"
        v-model="middleName"
        placeholder="Deuxième Prénom"
      />

      <!-- Last Name -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="text"
        v-model="lastName"
        placeholder="Nom de Famille"
      />

      <!-- Date of Birth -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="date"
        v-model="dateOfBirth"
        placeholder="Date de Naissance"
      />

      <!-- Country Dropdown -->
      <select
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        v-model="country"
      >
        <option disabled value="">Sélectionnez un Pays</option>
        <option value="République Centrafricaine">République Centrafricaine</option>
        <option value="Autre Pays">Autre Pays</option>
      </select>

      <!-- Town Dropdown (if Central African Republic is selected) -->
      <div v-if="country === 'République Centrafricaine'">
        <select
          class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
          v-model="town"
        >
          <option disabled value="">Sélectionnez une Ville</option>
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
        placeholder="Numéro de Téléphone"
      />

      <!-- Username -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="text"
        v-model="username"
        placeholder="Nom d'utilisateur"
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
        placeholder="Mot de Passe"
      />

      <!-- Confirm Password -->
      <input
        class="w-full p-3 mb-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        type="password"
        v-model="passwordConfirmation"
        placeholder="Confirmez le Mot de Passe"
      />

      <!-- Submit Button -->
      <button
        type="submit"
        class="w-full py-3 bg-yellow-500 text-white rounded-lg hover:bg-yellow-600 transition-colors duration-300 font-semibold cursor-pointer"
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
      Vous avez déjà un compte ?
      <router-link
        to="/login"
        class="text-yellow-500 font-semibold hover:underline hover:text-yellow-600 transition-colors duration-300"
      >
        Connectez-vous
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

    // Fetch towns from the store
    onMounted(() => {
      if (!userStore.towns.length) {
        userStore.fetchTowns();
      }
    });

    watch(country, (newCountry) => {
      if (newCountry !== 'République Centrafricaine') {
        town.value = "";
      }
    });

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
        if (userStore.isAuthenticated) {
          if (userStore.user && userStore.user.id) {
            router.push(`/dashboard/${userStore.user.id}`);
          } else {
            signUpError.value = "Les données utilisateur ne sont pas disponibles.";
          }
        } else {
          signUpError.value = "L'inscription a échoué. Veuillez réessayer.";
        }
      } catch (error) {
        console.error('Erreur d\'inscription:', error.response ? error.response.data : error.message);
        signUpError.value = "Une erreur est survenue lors de l'inscription. Veuillez réessayer.";
      }
    };

    return {
      firstName,
      middleName,
      lastName,
      dateOfBirth,
      town,
      towns: userStore.towns,
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
