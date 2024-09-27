<template>
  <div>
    <header class="bg-gradient-to-r from-black to-goldColor flex flex-wrap sm:justify-start sm:flex-nowrap w-full -mb-10 shadow -mt-6">
      <nav class="max-w-[85rem] w-full mx-auto px-4 sm:flex sm:items-center sm:justify-between">
        <div class="flex items-center justify-between">
          <a class="flex-none focus:outline-none focus:opacity-80" href="#">
            <img src="../assets/images/meya-logo.png" alt="Meya Logo" class="h-44 w-auto block p-0 mt-0 align-middle">
          </a>
          <div class="sm:hidden">
            <button type="button" class="hs-collapse-toggle relative size-7 flex justify-center items-center gap-2 rounded-lg border border-gray-700 font-medium bg-gray-800 text-gray-400 shadow-sm align-middle hover:bg-gray-700/20 focus:outline-none focus:bg-gray-700/20 text-sm" id="hs-navbar-dark-collapse" aria-expanded="false" aria-controls="hs-navbar-dark" aria-label="Toggle navigation" data-hs-collapse="#hs-navbar-dark">
              <svg class="hs-collapse-open:hidden shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="3" x2="21" y1="6" y2="6"/><line x1="3" x2="21" y1="12" y2="12"/><line x1="3" x2="21" y1="18" y2="18"/></svg>
              <svg class="hs-collapse-open:block hidden shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>
            </button>
          </div>
        </div>

        <div id="hs-navbar-dark" class="hidden hs-collapse overflow-hidden transition-all duration-300 basis-full grow sm:block">
          <div class="flex flex-col gap-5 mt-5 sm:flex-row sm:items-center sm:justify-end sm:mt-0 sm:ps-5">
            <!-- "Se connecter" Link with Outline -->
            <router-link to="/login" class="font-medium text-white focus:outline-none border border-white py-2 px-4 rounded-lg hover:bg-white hover:text-black transition duration-200" aria-current="page">
              Se connecter
            </router-link>
            <!-- "S'inscrire" Button, now larger -->
            <router-link to="/signup" custom v-slot="{ navigate }">
              <button @click="navigate" type="button" class="py-3 px-5 inline-flex items-center gap-x-2 text-base font-medium rounded-lg border border-goldColor bg-goldColor text-gray-800 shadow-sm hover:bg-gray-50 focus:outline-none focus:bg-gray-50 transition duration-200">
                S'incrire
              </button>
            </router-link>
          </div>
        </div>
      </nav>
    </header>
    <div class="bg-gradient-to-r from-black to-goldColor py-16 animate__animated animate__fadeInRight -mt-24">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center px-8 mx-auto max-w-screen-xl">
        <div class="flex flex-col justify-center items-start -mt-10">
          <h1 class="text-5xl font-bold leading-normal mb-4 text-white font-mona">Votre partenaire financier tout-en-un</h1>
          <p class="mb-4 text-lg font-mona text-white">
            Notre fintech vous propose des solutions innovantes pour gérer vos finances en toute simplicité.
            Avec des frais réduits, des transferts rapides, et une carte de débit intuitive, nous facilitons l'accès aux services bancaires pour tous.
          </p>
          <div class="flex space-x-4">
            <button class="bg-goldColor text-black rounded py-2 px-4 hover:bg-goldColor-light">Découvrir nos services</button>
            <button class="bg-transparent border border-goldColor text-white rounded py-2 px-4 hover:bg-goldColor hover:text-black">Découvrir nos services</button>
          </div>

        </div>
        <div class="flex justify-center items-center -mt-6 ml-12">
          <img src="../assets/images/glass-credit.png" alt="Fintech Solutions" class="max-w-3xl animate-zoomInOut">
        </div>

      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center px-8 mx-auto max-w-screen-xl">
        <div class="flex flex-col justify-center items-start">
          <h3 class="text-2xl font-bold leading-normal mb-4 text-goldColor font-mona">1. Transfert RapideVotre</h3>
          <p class="mb-4 text-lg font-mona text-white">
            Profitez d'un transfert instantané, sécurisé et sans tracas pour vos besoins financiers. Rapidité et efficacité garanties.
          </p>
        </div>
        <div class="flex flex-col justify-center items-start">
          <h3 class="text-2xl font-bold leading-normal mb-4 text-goldColor font-mona">2.Système Facile à Utiliser</h3>
          <p class="mb-4 text-lg font-mona text-white">
            Interface intuitive pour des opérations rapides et sans effort. Simplifiez vos tâches quotidiennes facilement."
          </p>
        </div>
      </div>
    </div>
    <!-- Section 1: Importance of Bank Account -->
    <div class="bg-white py-16 animate__animated animate__fadeInLeft">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center px-8 mx-auto max-w-screen-xl">
        <div class="flex justify-center items-center">
          <!-- Image placeholder -->
          <img src="../assets/images/man-holding-card.png" alt="Personal Bank" class="max-w-lg rounded-lg">
        </div>
        <div class="flex flex-col justify-center items-start">
          <h1 class="text-2xl font-bold mb-4 font-mona text-goldColor">Pourquoi un compte bancaire est important ?</h1>
          <p class="mb-4 text-lg font-mona">
            Un compte bancaire vous donne accès à des services essentiels comme les paiements, l'épargne, et la gestion de vos finances.
            C'est un élément crucial pour assurer votre sécurité financière et profiter d'une meilleure gestion de votre argent au quotidien.
          </p>
          <button class="bg-goldColor text-black rounded py-2 px-4 hover:bg-goldColor-light">En savoir plus</button>
        </div>
      </div>
    </div>

    <!-- Section 2: Why Choose Our Fintech -->
    <div class="bg-gray-100 py-16 animate__animated animate__fadeInRight">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center px-8 mx-auto max-w-screen-xl">
        <div class="flex flex-col justify-center items-start">
          <h1 class="text-2xl font-bold mb-4 font-mona text-goldColor">Pourquoi choisir notre fintech ?</h1>
          <p class="mb-4 text-lg">
            Notre fintech vous propose des solutions innovantes pour gérer vos finances en toute simplicité.
            Avec des frais réduits, des transferts rapides, et une carte de débit intuitive, nous facilitons l'accès aux services bancaires pour tous.
          </p>
          <button class="bg-goldColor text-black rounded py-2 px-4 hover:bg-goldColor-light">Découvrir nos services</button>
        </div>
        <div class="flex justify-center items-center">
          <!-- Image placeholder -->
          <img src="../assets/images/payment-by-phone.png" alt="Fintech Solutions" class="max-w-lg rounded-lg">
        </div>
      </div>
    </div>

    <footer class="bg-white dark:bg-black">
      <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
        <div class="sm:flex sm:items-center sm:justify-between">
          <a href="https://flowbite.com/" class="flex items-center mb-4 sm:mb-0 space-x-3 rtl:space-x-reverse">
              <img src="../assets/images/meya-logo.png" class="h-10" alt="Meya Logo" />
              <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">Meya</span>
          </a>
          <ul class="flex flex-wrap items-center mb-6 text-sm font-medium text-gray-500 sm:mb-0 dark:text-gray-400">
              <li>
                  <a href="#" class="hover:underline me-4 md:me-6">About</a>
              </li>
              <li>
                  <a href="#" class="hover:underline me-4 md:me-6">Privacy Policy</a>
              </li>
              <li>
                  <a href="#" class="hover:underline me-4 md:me-6">Licensing</a>
              </li>
              <li>
                  <a href="#" class="hover:underline">Contact</a>
              </li>
          </ul>
        </div>
        <hr class="my-6 border-gray-200 sm:mx-auto dark:border-gray-700 lg:my-8" />
        <span class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">© 2024 <a href="https://flowbite.com/" class="hover:underline">Meya™</a>. All Rights Reserved.</span>
      </div>
    </footer>



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
    }

    return {
      email,
      signUp
    }
  }
}
</script>

<style>
/* Custom styles for background and animation */
.bg-background2 {
  background-color: #f7f7f7;
}
</style>
