import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['var(--font-body)', 'sans-serif'],
        display: ['var(--font-display)', 'serif'],
      },
      colors: {
        // Nexus palette — definida en globals.css como CSS vars
        primary: 'var(--color-primary)',
        surface: 'var(--color-surface)',
        border: 'var(--color-border)',
      },
    },
  },
  plugins: [],
}

export default config
