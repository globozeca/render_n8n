# -----------------------------
# Dockerfile: Evolution API + Redis interno (Render Free)
# -----------------------------
FROM node:18-alpine

# Diretório de trabalho
WORKDIR /app

# Variáveis
ENV NODE_ENV=production \
    PORT=3000 \
    REDIS_HOST=127.0.0.1 \
    REDIS_PORT=6379

# Pacotes necessários: redis, curl, bash
RUN apk add --no-cache redis curl bash

# Copia manifestos e instala dependências de produção
COPY package*.json ./
# Use npm ci se você tiver package-lock.json versionado; caso contrário, mantenha install
# RUN npm ci --omit=dev --no-audit --no-fund
RUN npm install --omit=dev --no-audit --no-fund

# Copia o restante do código e arquivos auxiliares
COPY . .
# Copia config do Redis e entrypoint (ver abaixo)
COPY redis.conf ./redis.conf
COPY entrypoint.sh ./entrypoint.sh

# Pasta de dados do Redis (mesmo ephemeral)
RUN mkdir -p /app/redis-data && \
    chown -R node:node /app && \
    chmod +x /app/entrypoint.sh

# User não-root (vamos rodar redis e node com o mesmo user)
USER node

# Exposição da porta HTTP da API (Redis fica só em localhost)
EXPOSE 3000

# Healthcheck: verifica API e Redis
# - HTTP: /health (ajuste se sua API usa "/")
# - Redis: redis-cli ping (usa host 127.0.0.1)
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
  CMD sh -c 'curl -fsS http://127.0.0.1:${PORT}/health || curl -fsS http://127.0.0.1:${PORT}/ || exit 1' && \
      sh -c 'redis-cli -h 127.0.0.1 -p 6379 ping | grep -q PONG || exit 1'

# Entrypoint que sobe o Redis e inicia a API
ENTRYPOINT ["/app/entrypoint.sh"]
