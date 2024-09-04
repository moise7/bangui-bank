import { defineStore } from 'pinia';
import axios from 'axios';

export const useUserStore = defineStore('user', {
  state: () => ({
    isAuthenticated: false,
    user: null,
  }),
  actions: {
    async registerUser(data) {
      try {
        const response = await axios.post('/api/v1/sign_up', data); // Match endpoint with Rails route
        this.isAuthenticated = true;
        this.user = response.data.user;
      } catch (error) {
        console.error('Registration failed:', error);
        throw error;
      }
    },
    // Add other actions if needed
  },
  getters: {
    isAuthenticated: (state) => state.isAuthenticated,
    getUserEmail: (state) => state.user?.email,
    getUserID: (state) => state.user?.id,
    getUsername: (state) => state.user?.username,
  },
});
