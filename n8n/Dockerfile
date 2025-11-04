# ==========================================================
# DOCKERFILE - n8n (Render Free Tier)
# ==========================================================
FROM n8nio/n8n:latest

WORKDIR /data

ENV GENERIC_TIMEZONE=Africa/Luanda
ENV NODE_ENV=production
ENV NODE_OPTIONS="--max-old-space-size=256"

EXPOSE 5678

CMD ["n8n", "start"]
