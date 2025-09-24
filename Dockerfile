FROM node:18-slim

# Instalar solo lo mínimo necesario para Chromium
RUN apt-get update && apt-get install -y \
    chromium \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar y instalar dependencias
COPY package.json ./
RUN npm install --production --no-audit --no-fund

# Copiar el resto de la aplicación
COPY . .

# Variables de entorno
ENV NODE_ENV=production
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Puerto dinámico de Railway
EXPOSE ${PORT:-3001}

CMD ["node", "server.js"]