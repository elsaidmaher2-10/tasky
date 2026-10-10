import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// base './' keeps every asset path relative, so the static build works from any
// sub-path (GitHub Pages project sites, Netlify, Firebase Hosting, a plain folder).
export default defineConfig({
  base: './',
  plugins: [react()],
});
