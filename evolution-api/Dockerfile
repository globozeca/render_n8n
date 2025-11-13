# Reset ao NODE_OPTIONS
ARG NODE_OPTIONS=""

FROM node:18-alpine

WORKDIR /app

COPY evolution-api/package*.json ./

# Usar npm install porque o projeto não tem package-lock.json
RUN npm install --omit=dev --ignore-scripts --no-audit --no-fund

COPY . .

ENV NODE_ENV=production
ENV TZ=Africa/Luanda
ENV LOG_LEVEL=warn
ENV EVOLUTION_MAX_CONNECTIONS=50
ENV EVOLUTION_MAX_PAYLOAD=2mb

EXPOSE 8080

CMD ["npm", "start"]
