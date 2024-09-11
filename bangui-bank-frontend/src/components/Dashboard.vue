<template>
  <div class="dashboard">
    <nav class="top-nav">
      <a href="#" v-for="item in navItems" :key="item" @click="handleNavClick(item)">
        {{ item }}
      </a>
    </nav>

    <div class="dashboard-content">
      <!-- Accounts Section -->
      <div class="accounts-section" v-if="userStore.user && userStore.user.username">
        <h2>User Information</h2>
        <p><strong>Name:</strong> {{ userStore.user.username }}</p>
        <p><strong>Available Balance</strong> {{ userStore.user.balance }}</p>
        <p><strong>Created At:</strong> {{ new Date(userStore.user.created_at).toLocaleDateString() }}</p>
      </div>
      <router-link to="/transfer-form" class="make-transfer">Make a Transfer</router-link>

      <div class="account-actions">
        <h3>Make Transfer</h3>
        <router-link to="/transfer-form" class="btn-transfer">Send Money</router-link>
        <button class="btn-settings">Settings</button>
      </div>

      <!-- Payment History Section -->
      <div class="payment-history">
        <h3>Payment History</h3>
        <ul class="payment-list">
          <li v-for="payment in payments" :key="payment.id">
            <div class="payment-date">{{ payment.date }}</div>
            <div class="payment-description">{{ payment.description }}</div>
            <div class="payment-amount">{{ payment.amount }}</div>
          </li>
        </ul>
      </div>

      <!-- Payment Section -->
      <div class="payment-section">
        <h2>Make a Payment</h2>
        <p>Make paying bills fast and easy</p>
        <p>Pay your bills on one screen in seconds.</p>
        <button class="btn-signup">Sign up for payments</button>
      </div>

      <!-- Money Management Section -->
      <div class="money-management">
        <h2>Money Management</h2>
        <div class="tabs">
          <button class="active">Budgets</button>
          <button>Spending</button>
        </div>
        <!-- Placeholder for budget/spending visualization -->
        <div class="visualization-placeholder"></div>
      </div>

      <!-- Calculator and Calendar Section -->
      <div class="calculator-and-calendar">
        <div class="calculator">
          <div class="calculator-display" ref="calculatorDisplay">0</div>
          <div class="calculator-buttons">
            <button v-for="btn in calculatorButtons" :key="btn" @click="handleCalculatorButtonClick(btn)">
              {{ btn }}
            </button>
          </div>
        </div>

        <div class="calendar">
          <div class="calendar-header">
            <button @click="previousMonth">&lt;</button>
            <h3>{{ currentMonthYear }}</h3>
            <button @click="nextMonth">&gt;</button>
          </div>
          <div class="calendar-grid">
            <div v-for="day in daysOfWeek" :key="day" class="calendar-day-header">{{ day }}</div>
            <div v-for="date in calendarDates" :key="date.getTime()"
                  :class="['calendar-day', { 'current-month': isCurrentMonth(date), 'today': isToday(date) }]">
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
      navItems: ['Accounts', 'Move Money', 'Financial Tools', 'Card Control', 'Send Money', 'Additional Services', 'Logout'],
      currentDate: new Date(),
      daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
      calculatorButtons: ['C', '±', '%', '÷', '7', '8', '9', '×', '4', '5', '6', '-', '1', '2', '3', '+', '0', '.', '='],
      payments: [
        { id: 1, date: '2024-08-01', description: 'Electric Bill', amount: '-$120.45' },
        { id: 2, date: '2024-07-28', description: 'Internet Bill', amount: '-$60.00' },
        { id: 3, date: '2024-07-15', description: 'Phone Bill', amount: '-$30.00' },
        // Add more payments as needed
      ],
      user: null, // Data property for user information
    }
  },
  setup() {
    const userStore = useUserStore();
    const router = useRouter();
    const navItems = ['Accounts', 'Move Money', 'Financial Tools', 'Card Control', 'Send Money', 'Additional Services', 'Logout'];

    function handleNavClick(item) {
      if (item === 'Logout') {
        userStore.logout(); // Call the logout method
        router.push('/'); // Redirect to the home page
      } else if (item === 'Send Money') {
        router.push('/send-money');
      }
    }

    onMounted(async () => {
      await userStore.fetchUserData();
    });

    return {
      userStore,
      handleNavClick,
      navItems,
    };
  },
  computed: {
    currentMonthYear() {
      return this.currentDate.toLocaleString('default', { month: 'long', year: 'numeric' });
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
    }
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
          display.innerText = 'Error';
        }
      } else {
        if (currentText === '0') {
          display.innerText = button;
        } else {
          display.innerText += button;
        }
      }
    }
  },
};
</script>

<style scoped>
.dashboard {
  font-family: Arial, sans-serif;
}

.top-nav {
  background-color: #003366;
  color: white;
  padding: 10px;
}

.top-nav a {
  color: white;
  text-decoration: none;
  margin-right: 15px;
  cursor: pointer;
}

.dashboard-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  padding: 20px;
}

.accounts-section {
  background-color: #f8f8f8;
  padding: 15px;
  border: 1px solid #ddd;
  border-radius: 8px;
}

.account-actions {
  margin-bottom: 15px;
}

.payment-history {
  margin-top: 20px;
  background-color: #f8f8f8;
  padding: 15px;
  border: 1px solid #ddd;
  border-radius: 8px;
}

.payment-history h3 {
  margin-top: 0;
}

.payment-list {
  list-style-type: none;
  padding: 0;
}

.payment-list li {
  border-bottom: 1px solid #ddd;
  padding: 10px 0;
  display: flex;
  justify-content: space-between;
}

.payment-date, .payment-description, .payment-amount {
  flex: 1;
  text-align: left;
}

.payment-amount {
  text-align: right;
}

.btn-transfer, .btn-settings, .btn-signup {
  background-color: #cc5500;
  color: white;
  border: none;
  padding: 10px 15px;
  cursor: pointer;
}

.calculator-and-calendar {
  display: flex;
  flex-direction: column;
}

.calculator {
  margin-bottom: 20px;
}

.calculator-display {
  background-color: #f0f0f0;
  padding: 10px;
  text-align: right;
  font-size: 1.5em;
}

.calculator-buttons {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 5px;
}

.calculator-buttons button {
  padding: 10px;
  font-size: 1em;
  background-color: #e0e0e0;
  border: none;
  cursor: pointer;
}

.calendar {
  font-size: 0.8em;
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 5px;
}

.calendar-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 2px;
}

.calendar-day-header, .calendar-day {
  text-align: center;
  padding: 2px;
}

.calendar-day {
  border: 1px solid #eee;
}

.current-month {
  background-color: #f0f0f0;
}

.today {
  background-color: #e6f2ff;
  font-weight: bold;
}

.btn-transfer {
  text-decoration: none;
  margin-right: 15px; /* Add space between Transfer and Settings */
}

.btn-settings {
  margin-left: 15px; /* Add space between Settings and other elements */
}

.btn-signup {
  margin-top: 20px; /* Add space above the Sign up button */
}
</style>
