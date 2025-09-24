// IMPORTANTE: Reemplaza estas líneas al inicio de server.js

const express = require('express');
const cors = require('cors');
const path = require('path');
const puppeteer = require('puppeteer');
const crypto = require('crypto');
const fs = require('fs');

const app = express();
// Railway proporciona el puerto dinámicamente
const PORT = process.env.PORT || 3001;

// Middlewares
app.use(cors());
app.use(express.json({ limit: '10mb' }));

// Servir archivos estáticos desde la carpeta actual si no existe 'public'
if (fs.existsSync(path.join(__dirname, 'public'))) {
    app.use(express.static('public'));
} else {
    // Si index.html está en la raíz
    app.use(express.static(__dirname));
}

// CONFIGURACIÓN CRÍTICA DE PUPPETEER PARA RAILWAY
const isProduction = process.env.NODE_ENV === 'production' || process.env.RAILWAY_ENVIRONMENT;

const puppeteerConfig = {
    executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/chromium',
    headless: 'new',
    args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-gpu',
        '--no-first-run',
        '--no-zygote',
        '--single-process', // Importante para contenedores
        '--disable-extensions'
    ],
    defaultViewport: {
        width: 1920,
        height: 1080
    },
    ignoreHTTPSErrors: true
};

// El resto del código continúa igual...