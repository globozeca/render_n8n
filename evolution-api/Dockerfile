# ==========================================================
# DOCKERFILE - Evolution API (Render Free Tier)
# ==========================================================
FROM node:18-alpine

WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install --omit=dev

COPY . .

ENV NODE_ENV=production
ENV PORT=3000
ENV NODE_OPTIONS="--max-old-space-size=256"

EXPOSE 3000

CMD ["npm", "run", "start"]
