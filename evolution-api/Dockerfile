# ----------------------------------------------------------
# Evolution API - Dockerfile otimizado para Render Free Tier
# ----------------------------------------------------------
FROM node:18-alpine

WORKDIR /app

# ===========================================
# Variáveis de ambiente padrão
# ===========================================
ENV NODE_ENV=production \
    PORT=3000 \
    REDIS_HOST=127.0.0.1 \
    REDIS_PORT=6379 \
    NODE_OPTIONS="--max-old-space-size=256 --optimize_for_size --max_semi_space_size=4"

# ===========================================
# Instalar somente o necessário
# ===========================================
RUN apk add --no-cache redis bash curl tini

# ===========================================
# Instalar dependências da aplicação
# ===========================================
COPY package*.json ./
RUN npm ci --omit=dev --ignore-scripts --no-audit --no-fund

# Copiar código
COPY . .

# ===========================================
# Criar redis.conf otimizado
# ===========================================
RUN cat > /app/redis.conf <<'EOF'
port 6379
bind 127.0.0.1
protected-mode yes
daemonize no
save ""
appendonly no
dir /app/redis-data
logfile ""
# Mantém baixo uso de RAM
maxmemory 64mb
maxmemory-policy allkeys-lru
EOF

# ===========================================
# Criar entrypoint.sh mais leve e seguro
# ===========================================
RUN cat > /app/entrypoint.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

_term() {
  echo "Finalizando serviços..."
  [ -n "${API_PID:-}" ] && kill "$API_PID" 2>/dev/null || true
  [ -n "${REDIS_PID:-}" ] && redis-cli -h 127.0.0.1 -p 6379 shutdown nosave || true
  wait || true
  exit 0
}
trap _term TERM INT

echo "[1/3] Iniciando Redis..."
redis-server /app/redis.conf &
REDIS_PID=$!

echo "[2/3] Aguardando Redis..."
for i in {1..20}; do
  redis-cli ping > /dev/null 2>&1 && break
  sleep 1
done

echo "[3/3] Iniciando Evolution API..."
npm run start &
API_PID=$!

wait -n || true
_term
EOF

# Permissões e diretórios
RUN mkdir -p /app/redis-data && \
    chmod +x /app/entrypoint.sh

USER node

EXPOSE 3000

ENTRYPOINT ["/sbin/tini","--","/app/entrypoint.sh"]
