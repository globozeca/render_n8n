# -----------------------------
# Dockerfile para Evolution API
# -----------------------------
FROM node:18-alpine

# Diretório de trabalho
WORKDIR /app

# Copia apenas ficheiros necessários
COPY package.json package-lock.json ./

# Instala dependências (modo produção)
RUN npm install --omit=dev

# Copia o código fonte
COPY . .

# Define variáveis padrão (Render substitui por env)
ENV NODE_ENV=production
ENV PORT=3000

# Expõe a porta da API
EXPOSE 3000

# Inicia a aplicação
CMD ["npm", "run", "start"]
