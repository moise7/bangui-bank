import { defineStore } from 'pinia';
import axios from 'axios';

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null, // To store the user data
    token: null, // To store the authentication token
  }),
  actions: {
    async loginUser(credentials) {
      try {
        const response = await axios.post('http://localhost:3000/api/login', credentials);
        this.user = response.data.user;
        this.token = response.data.token;
        // You may want to save the token in local storage for persistence
        localStorage.setItem('token', this.token);
      } catch (error) {
        console.error('Login failed:', error);
      }
    },
    async fetchUserData() {
      try {
        const response = await axios.get('http://localhost:3000/api/users/me', {
          headers: { Authorization: `Bearer ${this.token}` },
        });
        this.user = response.data;
      } catch (error) {
        console.error('Failed to fetch user data:', error);
      }
    },
    logout() {
      this.user = null;
      this.token = null;
      localStorage.removeItem('token');
    },
  },
  getters: {
    isAuthenticated: (state) => !!state.user,
  },
  persist: true, // Optional: use if you want to persist the store in local storage
});
