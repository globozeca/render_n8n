# ------------------------------------------------------
# Evolution API - Dockerfile para Render (Free Tier)
# Optimizado e sem erros NODE_OPTIONS
# ------------------------------------------------------

# Reset ao NODE_OPTIONS (Render injecta variáveis no build)
ARG NODE_OPTIONS=""

FROM node:18-alpine

# Workdir
WORKDIR /app

# Copiar definições
COPY package*.json ./

# Instalar só produção
RUN npm ci --omit=dev --ignore-scripts --no-audit --no-fund

# Copiar resto do código
COPY . .

# Variáveis de performance para produção
ENV NODE_ENV=production
ENV TZ=Africa/Luanda

# Desactivar logs pesados
ENV LOG_LEVEL=warn

# Optimizar memória para Render (512 MB máx)
ENV EVOLUTION_MAX_CONNECTIONS=50
ENV EVOLUTION_MAX_PAYLOAD=2mb

# Expor porta
EXPOSE 8080

# Iniciar
CMD ["npm", "start"]
