# -----------------------------
# Dockerfile: Evolution API + Redis interno (Render Free) sem arquivos externos
# -----------------------------
FROM node:18-alpine

WORKDIR /app

ENV NODE_ENV=production \
    PORT=3000 \
    REDIS_HOST=127.0.0.1 \
    REDIS_PORT=6379

# Instala redis, curl e sh
RUN apk add --no-cache redis curl bash

# Copia manifestos e instala dependências de produção
COPY package*.json ./
# Se você tiver package-lock.json versionado, pode trocar para npm ci:
# RUN npm ci --omit=dev --no-audit --no-fund
RUN npm install --omit=dev --no-audit --no-fund

# Copia o restante do código da aplicação
COPY . .

# --- Cria redis.conf dentro da imagem ---
RUN cat > /app/redis.conf <<'EOF'
port 6379
bind 127.0.0.1
protected-mode yes
daemonize no
save ""
appendonly no
dir /app/redis-data
logfile ""
# Descomente para limitar memória no free tier:
# maxmemory 128mb
# maxmemory-policy allkeys-lru
EOF

# --- Cria entrypoint.sh dentro da imagem ---
RUN cat > /app/entrypoint.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

_term() {
  echo "Recebido sinal, encerrando..."
  if [ -n "${API_PID:-}" ] && kill -0 "$API_PID" 2>/dev/null; then
    kill -TERM "$API_PID" || true
  fi
  if [ -n "${REDIS_PID:-}" ] && kill -0 "$REDIS_PID" 2>/dev/null; then
    redis-cli -h 127.0.0.1 -p 6379 shutdown nosave || kill -TERM "$REDIS_PID" || true
  fi
  wait || true
  exit 0
}
trap _term TERM INT

echo "Iniciando Redis local..."
redis-server /app/redis.conf &
REDIS_PID=$!

echo "Aguardando Redis responder PING..."
for i in $(seq 1 30); do
  if redis-cli -h 127.0.0.1 -p 6379 ping | grep -q PONG; then
    echo "Redis pronto."
    break
  fi
  sleep 1
  if ! kill -0 "$REDIS_PID" 2>/dev/null; then
    echo "Redis terminou inesperadamente."; exit 1
  fi
  if [ "$i" -eq 30 ]; then
    echo "Timeout esperando Redis."; exit 1
  fi
done

echo "Iniciando Evolution API..."
npm run start &
API_PID=$!

wait -n || true
# Se um morrer, encerra o outro para reinício limpo
_term
EOF

# Permissões e diretório de dados
RUN mkdir -p /app/redis-data && \
    chown -R node:node /app && \
    chmod +x /app/entrypoint.sh

# Rodar como usuário não-root
USER node

EXPOSE 3000

# Healthcheck HTTP (+ opcional) — ajuste /health se necessário
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
  CMD sh -c 'curl -fsS http://127.0.0.1:${PORT}/health || curl -fsS http://127.0.0.1:${PORT}/ || exit 1' && \
      sh -c 'redis-cli -h 127.0.0.1 -p 6379 ping | grep -q PONG || exit 1'

ENTRYPOINT ["/app/entrypoint.sh"]
