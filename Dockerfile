node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.env.local# Use official Node.js image
FROM node:18-slim

# Install dependencies for Puppeteer
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-sandbox \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libwayland-client0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Set Puppeteer to skip download
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV NODE_ENV=production

# Install dependencies
RUN npm ci --only=production

# Copy application files
COPY . .

# Expose port
EXPOSE 3001

# Start the application
CMD ["node", "server.js"]
leads.csv
.cache
.vscode
.idea
*.swp
*.swo
.DS_Store