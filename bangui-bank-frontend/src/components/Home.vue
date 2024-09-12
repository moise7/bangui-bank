<template>
  <div>
    <header class="sticky top-0 z-50 flex flex-wrap sm:justify-start sm:flex-nowrap w-full bg-gray-800 text-sm py-3">
      <nav class="max-w-[85rem] w-full mx-auto px-4 sm:flex sm:items-center sm:justify-between">
        <div class="flex items-center justify-between">
          <a class="flex-none text-xl font-semibold text-white focus:outline-none focus:opacity-80" href="#">Babara Bank</a>
          <div class="sm:hidden">
            <button type="button" class="hs-collapse-toggle relative size-7 flex justify-center items-center gap-2 rounded-lg border border-gray-700 font-medium bg-gray-800 text-gray-400 shadow-sm align-middle hover:bg-gray-700/20 focus:outline-none focus:bg-gray-700/20 text-sm" id="hs-navbar-dark-collapse" aria-expanded="false" aria-controls="hs-navbar-dark" aria-label="Toggle navigation" data-hs-collapse="#hs-navbar-dark">
              <svg class="hs-collapse-open:hidden shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="3" x2="21" y1="6" y2="6"/><line x1="3" x2="21" y1="12" y2="12"/><line x1="3" x2="21" y1="18" y2="18"/></svg>
              <svg class="hs-collapse-open:block hidden shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>
            </button>
          </div>
        </div>
        <div id="hs-navbar-dark" class="hidden hs-collapse overflow-hidden transition-all duration-300 basis-full grow sm:block" aria-labelledby="hs-navbar-dark-collapse">
          <div class="flex flex-col gap-5 mt-5 sm:flex-row sm:items-center sm:justify-end sm:mt-0 sm:ps-5">
            <router-link to="/login" class="font-medium text-white focus:outline-none" aria-current="page">Se connecter</router-link>
            <router-link to="/signup" custom v-slot="{ navigate }">
              <button @click="navigate" type="button" class="py-2 px-3 inline-flex items-center gap-x-2 text-sm font-medium rounded-lg border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 focus:outline-none focus:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-800 dark:border-neutral-700 dark:text-white dark:hover:bg-neutral-700 dark:focus:bg-neutral-700">
                S'incrire
              </button>
            </router-link>
          </div>
        </div>
      </nav>
    </header>
    <!-- Main Content -->
    <body>
      <div class="bg-background2 py-24 text-center">
        <h1 class="text-4xl font-bold leading-normal">Votre partenaire financier tout-en-un. </h1>
        <p class="text-xl">Compte personnel, carte de débit pratique, transferts d'argent à faible coût—tout ce dont vous avez besoin est ici.</p>
        <div class="signup-form mt-3">
          <input
            v-model="email"
            type="email"
            placeholder="Enter your email"
            class="
              w-full lg:w-auto
              p-3 rounded border-gray-300
            focus:ring-gray-300
            focus:border-gray-300
            text-md"
          />
          <button
            class="ml-4 lg:w- text-white bg-gray-800 hover:bg-gray-900 focus:outline-none focus:ring-4 focus:ring-gray-300 font-medium rounded text-md p-3 dark:bg-gray-800 dark:hover:bg-gray-700 dark:focus:ring-gray-700 dark:border-gray-700"
            @click="signUp"
          >
            S'incrire
          </button>
        </div>
        <p class="account-info mt-3">Vous avez déjà un compte ?</p>
      </div>

      <div class="bg-white py-4">
        <div class="grid grid-cols-2 items-center px-8 mx-auto max-w-screen-xl">
          <!-- Text Section -->
          <div class="flex flex-col justify-center items-start">
            <h1 class="text-2xl font-bold mb-2">Banque Personnelle - Dites Adieu à l'Absence de Compte Bancaire</h1>
            <p class="mb-4 text-lg">
              vous n'avez plus à vous soucier de ne pas avoir de compte bancaire.
              Nous facilitons l'ouverture d'un compte personnel adapté à vos besoins,
              avec une gestion simple et accessible à tout moment. Profitez d'une expérience bancaire moderne et sécurisée, conçue pour vous simplifier la vie.
            </p>
            <button class="bg-blue-500 text-white rounded py-2 px-4 hover:bg-blue-600">En savoir plus</button>
          </div>
          <div class="flex justify-center items-center">
            <img src="../assets/images/personal-bank.jpg" alt="Personal Bank" class="max-w-lg">
          </div>
        </div>
      </div>

      <div class="bg-background2 py-4">
        <div class="grid grid-cols-2 items-center px-8 mx-auto max-w-screen-xl">
          <!-- Text Section -->
          <div class="flex flex-col justify-center items-start">
            <h1 class="text-2xl font-bold mb-2">Banque Personnelle - Dites Adieu à l'Absence de Compte Bancaire</h1>
            <p class="mb-4 text-lg">
              Nous avons une opportunité excitante pour vous ! En vous inscrivant dès maintenant, vous pouvez accéder à des offres exclusives et à des opportunités pour gagner de l'argent rapidement. Ne manquez pas cette chance unique !
              Pour plus d'informations, connectez-vous à votre compte et découvrez comment vous pouvez bénéficier de cette offre dès aujourd'hui.
            </p>
            <button class="bg-blue-500 text-white rounded py-2 px-4 hover:bg-blue-600">En savoir plus</button>
          </div>
          <div class="flex justify-center items-center">
            <img src="../assets/images/fast-money.png" alt="fast-money" class="max-w-lg">
          </div>
        </div>
      </div>
    </body>
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
