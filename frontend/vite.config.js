import {defineConfig} from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';
const proxy={'/api':{target:process.env.AQUATRACE_API_TARGET||'http://127.0.0.1:8002',changeOrigin:true}};
export default defineConfig({plugins:[react(),tailwindcss()],server:{port:5174,strictPort:true,proxy},preview:{port:4174,strictPort:true,proxy}});
