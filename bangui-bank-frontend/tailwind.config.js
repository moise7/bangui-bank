import typography from '@tailwindcss/typography';
import forms from '@tailwindcss/forms';
import aspectRatio from '@tailwindcss/aspect-ratio';

/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    container: {
      center: true,
      padding: "15px"
    },
    screens: {
      sm: "640px",
      md: "768px",
      lg: "960px",
      xl: "1200px"
    },
    extend: {
      colors: {
        primary: '#007B83',
        secondary: '#F5E6C4',
        accent: '#B39CD0',
        background1: '#FAF9F6',
        background2: '#ECECEC',
        btn: '#FFB385'
      }
    },
  },
  plugins: [
    typography,
    forms,
    aspectRatio,
  ],
}
