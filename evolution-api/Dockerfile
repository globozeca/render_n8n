# evolution-api/Dockerfile
# Dockerfile minimal, pensado para apps Node.js (Express / Fastify)
# Assumimos que o projecto tem package.json com scripts: "start" e "build" se necessário.

FROM node:18-alpine AS builder
WORKDIR /usr/src/app

# Dependências de compilação (se houver)
COPY package*.json ./
# Se usas pnpm/yarn ajusta aqui
RUN npm ci --production

# Copia código
COPY . .

# Se tens build step
# RUN npm run build

# --- imagem final ---
FROM node:18-alpine
WORKDIR /usr/src/app

# Cria um user não-root (melhor segurança)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Copia node_modules e código do builder
COPY --from=builder /usr/src/app /usr/src/app

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

# Start command (Render vai usar o startCommand do render.yaml)
CMD ["npm", "run", "start"]
