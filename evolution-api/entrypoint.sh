#!/usr/bin/env bash
set -euo pipefail

# Encaminha SIGTERM/SIGINT para subprocessos (Redis e Node)
_term() {
  echo "Recebido sinal, encerrando..."
  # Tenta encerrar a API (se existir)
  if [ -n "${API_PID:-}" ] && kill -0 "$API_PID" 2>/dev/null; then
    kill -TERM "$API_PID" || true
  fi
  # Tenta encerrar o Redis
  if [ -n "${REDIS_PID:-}" ] && kill -0 "$REDIS_PID" 2>/dev/null; then
    redis-cli -h 127.0.0.1 -p 6379 shutdown nosave || kill -TERM "$REDIS_PID" || true
  fi
  wait || true
  exit 0
}
trap _term TERM INT

echo "Iniciando Redis local..."
# Inicia Redis em foreground (sem daemonize) com a config fornecida
redis-server /app/redis.conf &
REDIS_PID=$!

# Aguarda Redis ficar disponível
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
# Inicie sua API (ajuste o script conforme seu package.json)
npm run start &
API_PID=$!

# Reap filho e mantém container vivo enquanto processos existirem
wait -n || true

# Se algum morreu, encerra o outro para reinício limpo pelo Render
_term
