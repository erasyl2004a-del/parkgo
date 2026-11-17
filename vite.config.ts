import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { VitePWA } from 'vite-plugin-pwa';
export default defineConfig({base:'/parkgo/',plugins:[react(),VitePWA({
 registerType:'autoUpdate',includeAssets:['parkgo.svg'],
 manifest:{name:'ParkGo — Akıllı Otopark',short_name:'ParkGo',description:"Türkiye'de otopark bulma ve park yönetimi",lang:'tr-TR',start_url:'/',scope:'/',display:'standalone',orientation:'portrait',background_color:'#f4f7fb',theme_color:'#071b35',icons:[{src:'/parkgo.svg',sizes:'any',type:'image/svg+xml',purpose:'any maskable'}]},
 workbox:{navigateFallback:'/index.html',globPatterns:['**/*.{js,css,html,svg,woff2}']}
})],server:{host:'0.0.0.0'}});