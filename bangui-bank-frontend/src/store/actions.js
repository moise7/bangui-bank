// // store/index.js
// import Vue from 'vue';
// import Vuex from 'vuex';
// import axios from 'axios';

// Vue.use(Vuex);

// export default new Vuex.Store({
//   state: {
//     user: null,  // Initial state for user
//   },
//   mutations: {
//     SET_USER(state, user) {
//       state.user = user;
//     },
//   },
//   actions: {
//     switchUser({ commit }, userId) {
//       axios.get(`/api/users/${userId}`)
//         .then(response => {
//           commit('SET_USER', response.data);
//         })
//         .catch(error => {
//           console.error("Error fetching user:", error);
//         });
//     },
//   },
// });
