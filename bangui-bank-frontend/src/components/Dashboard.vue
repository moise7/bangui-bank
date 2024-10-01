<template>
  <div class="dashboard font-mona bg-background1">
    <nav class="top-nav bg-goldColor text-black p-4">
      <a href="#"
         v-for="item in navItems"
         :key="item"
         @click="handleNavClick(item)"
         class="mr-4 hover:text-secondary transition">
        {{ item }}
      </a>
    </nav>

    <div class="title text-3xl text-center mt-6" v-if="userStore.user && userStore.user.username">
      <h1><strong>Bienvenue,</strong> {{ userStore.user.first_name }}</h1>
    </div>

    <!-- Accounts Section -->
    <div class="accounts-section bg-gray-100 p-4 mt-4 rounded-md shadow-md" v-if="userStore.user && userStore.user.username">
      <p class="text-lg"><strong>Solde disponible:</strong> {{ formattedBalance }} </p>
      <p class="text-sm"><strong>Créé le:</strong> {{ new Date(userStore.user.created_at).toLocaleDateString('fr-FR') }}</p>
      <select v-model="selectedCurrency" class="mt-2 p-2 border border-gray-300 rounded">
        <option value="€">Euro (€)</option>
        <option value="$">Dollar ($)</option>
        <option value="CFA">Central African CFA Franc (CFA)</option>
      </select>
    </div>

    <div class="dashboard-content grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 p-4">
      <!-- Payment History Section -->
      <div class="payment-history bg-gray-100 p-4 rounded-md shadow-md">
        <h3 class="text-xl font-bold mb-4">Historique des paiements</h3>
        <div class="flex font-bold border-b-2 border-gray-800 mb-2">
          <div class="flex-1 text-left py-1">Date</div>
          <div class="flex-1 text-left py-2">Nom</div>
          <div class="flex-1 text-left py-2">Description</div>
          <div class="flex-1 text-left py-2">Montant</div>
        </div>

        <ul class="list-none p-0">
          <li
            v-for="(payment, index) in userStore.payments"
            :key="payment.id"
            :class="{'bg-gray-200': index % 2 === 0, 'bg-white': index % 2 !== 0}"
            class="flex py-3 border-b border-gray-300"
          >
            <div class="flex-1">{{ new Date(payment.created_at).toLocaleDateString('fr-FR') }}</div>
            <div class="flex-1">{{ payment.recipient_first_name }} {{ payment.recipient_last_name }}</div>
            <div class="flex-1">{{ payment.description }}</div>
            <div class="flex-1">{{ formatCurrency(payment.amount) }}</div>
          </li>
        </ul>
      </div>

      <!-- Calculator and Calendar Section -->
      <div class="calculator-and-calendar space-y-4">
        <div class="calculator bg-gray-100 p-4 rounded-md shadow-md">
          <div class="calculator-display bg-gray-200 p-2 text-right text-2xl" ref="calculatorDisplay">0</div>
          <div class="calculator-buttons grid grid-cols-4 gap-2 mt-2">
            <button v-for="btn in calculatorButtons"
                    :key="btn"
                    @click="handleCalculatorButtonClick(btn)"
                    class="bg-goldColor text-white py-2 rounded hover:bg-black transition">
              {{ btn }}
            </button>
          </div>
        </div>

        <div class="calendar bg-gray-100 p-4 rounded-md shadow-md">
          <div class="calendar-header flex justify-between items-center mb-4">
            <button @click="previousMonth" class="bg-goldColor text-white py-1 px-2 rounded hover:bg-black transition">&lt;</button>
            <h3 class="text-lg font-bold">{{ currentMonthYear }}</h3>
            <button @click="nextMonth" class="bg-goldColor text-white py-1 px-2 rounded hover:bg-black transition">&gt;</button>
          </div>
          <div class="calendar-grid grid grid-cols-7">
            <div v-for="day in daysOfWeek" :key="day" class="calendar-day-header font-bold text-center">{{ day }}</div>
            <div v-for="date in calendarDates" :key="date.getTime()"
                  :class="['calendar-day border text-center p-2', { 'bg-blue-100': isCurrentMonth(date), 'bg-blue-300': isToday(date) }]">
              {{ date.getDate() }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { onMounted } from 'vue';
import { useUserStore } from '@/stores/user';
import { useRouter } from 'vue-router';

export default {
  name: 'BankingDashboard',
  data() {
    return {
      navItems: ['Comptes', 'Transférer de l\'argent', 'Outils financiers', 'Contrôle de carte', 'Envoyer de l\'argent', 'Services supplémentaires', 'Déconnexion'],
      currentDate: new Date(),
      daysOfWeek: ['Di', 'Lu', 'Ma', 'Me', 'Je', 'Ve', 'Sa'],
      calculatorButtons: ['C', '±', '%', '÷', '7', '8', '9', '×', '4', '5', '6', '-', '1', '2', '3', '+', '0', '.', '='],
      selectedCurrency: '€', // Default currency symbol
    };
  },
  setup() {
    const userStore = useUserStore();
    const router = useRouter();

    function handleNavClick(item) {
      if (item === 'Déconnexion') {
        userStore.logout();
        router.push('/');
      } else if (item === 'Envoyer de l\'argent') {
        router.push('/payment-form');
      }
    }

    onMounted(async () => {
      await userStore.fetchUserData();
      await userStore.fetchPayments();
      console.log('test', userStore.fetchPayments());
    });

    return {
      userStore,
      handleNavClick,
    };
  },
  computed: {
    formattedBalance() {
      return this.formatCurrency(this.userStore.user.balance);
    },
    currentMonthYear() {
      return this.currentDate.toLocaleString('fr-FR', { month: 'long', year: 'numeric' });
    },
    calendarDates() {
      const year = this.currentDate.getFullYear();
      const month = this.currentDate.getMonth();
      const firstDay = new Date(year, month, 1);
      const lastDay = new Date(year, month + 1, 0);

      const dates = [];
      const daysToIncludeBefore = firstDay.getDay();
      const daysToIncludeAfter = 6 - lastDay.getDay();

      for (let i = -daysToIncludeBefore; i < lastDay.getDate() + daysToIncludeAfter; i++) {
        dates.push(new Date(year, month, i + 1));
      }

      return dates;
    },
  },
  methods: {
    previousMonth() {
      this.currentDate = new Date(this.currentDate.getFullYear(), this.currentDate.getMonth() - 1);
    },
    nextMonth() {
      this.currentDate = new Date(this.currentDate.getFullYear(), this.currentDate.getMonth() + 1);
    },
    isCurrentMonth(date) {
      return date.getMonth() === this.currentDate.getMonth();
    },
    isToday(date) {
      const today = new Date();
      return date.getDate() === today.getDate() &&
             date.getMonth() === today.getMonth() &&
             date.getFullYear() === today.getFullYear();
    },
    handleCalculatorButtonClick(button) {
      const display = this.$refs.calculatorDisplay;
      let currentText = display.innerText;

      if (button === 'C') {
        display.innerText = '0';
      } else if (button === '=') {
        try {
          display.innerText = eval(currentText);
        } catch {
          display.innerText = 'Erreur';
        }
      } else {
        if (currentText === '0') {
          display.innerText = button;
        } else {
          display.innerText += button;
        }
      }
    },
    formatCurrency(amount) {
      if (this.selectedCurrency === 'CFA') {
        return `${amount} CFA`;
      }
      return `${this.selectedCurrency}${amount}`;
    },
  },
};
</script>

<style scoped>
.calendar-day {
  transition: background-color 0.3s;
}
</style>
