# -----------------------------
# Dockerfile para Evolution API (otimizado)
# -----------------------------
FROM node:18-alpine AS base

# Variáveis de ambiente padrão
ENV NODE_ENV=production \
    PORT=3000

# Diretório de trabalho
WORKDIR /app

# Instala utilitário para healthcheck
RUN apk add --no-cache curl

# Copia apenas manifestos para aproveitar cache de dependências
COPY package*.json ./

# Instala dependências de produção de forma reprodutível
# - npm ci garante consistência com package-lock.json
RUN npm ci --omit=dev

# Copia o restante do código
COPY . .

# (Opcional) Se houver etapa de build (TS/Bundlers), habilite:
# RUN npm run build

# Cria usuário não-root por segurança
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Expõe a porta da API
EXPOSE 3000

# Healthcheck da aplicação (ajuste a rota de saúde se necessário)
# Se sua API tiver /health, mantenha. Se não, troque por / (ou crie a rota).
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD curl -fsS http://localhost:${PORT}/health || curl -fsS http://localhost:${PORT}/ || exit 1

# Inicia a aplicação
# Use "start" para produção; se seu package.json usa outro script, ajuste aqui.
CMD ["npm", "run", "start"]
