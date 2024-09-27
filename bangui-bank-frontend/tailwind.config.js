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
    fontFamily: {
      sans: ['Mona Sans', 'sans-serif'],
    },
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
        goldColor: '#D1B65B',
        accent: '#B39CD0',
        background1: '#FAF9F6',
        background2: '#ECECEC',
        btn: '#FFB385',
        'goldColor-light': '#E2C39F', // Lighter shade of goldColor
        'goldColor-dark': '#B89B4F'
      },
      fontFamily: {
        'mona': ['Mona Sans', 'sans-serif'],
      },
      keyframes: {
        zoomInOut: {
          '0%, 100%': { transform: 'scale(1)' }, // At the start and end, the image is at its normal size
          '50%': { transform: 'scale(1.1)' }, // At the middle, the image is zoomed in by 10%
        },
      },
      animation: {
        zoomInOut: 'zoomInOut 2s ease-in-out infinite', // Define the animation with 2s duration and infinite loop
      },
    },
    // backgroundImage: {
    //   'custom-gradient': 'linear-gradient(to right, #000000 70%, #D1B65B 70%)',
    // },
  },
  plugins: [
    typography,
    forms,
    aspectRatio,
  ],
}
