# ==========================================================
# DOCKERFILE - n8n (Render Free Tier)
# ==========================================================
FROM n8nio/n8n:latest

WORKDIR /data

ENV GENERIC_TIMEZONE=Africa/Luanda
ENV NODE_ENV=production
ENV NODE_OPTIONS=--max-old-space-size=384
ENV N8N_RUNNERS_ENABLED=false
ENV N8N_TEMPLATES_ENABLED=false
ENV N8N_PERSONALIZATION_ENABLED=false
ENV N8N_METRICS=false
ENV N8N_HIRING_BANNER_DISABLED=true
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false
ENV N8N_AUTOMATIC_RESTART=false
ENV N8N_PRUNE_DATA=true
ENV N8N_PRUNE_DATA_MAX_AGE=168
ENV EXECUTIONS_DATA_SAVE_ON_SUCCESS=none
ENV EXECUTIONS_DATA_SAVE_ON_ERROR=all
ENV EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=false
ENV EXECUTIONS_TIMEOUT=600
ENV EXECUTIONS_TIMEOUT_RETRY=false
ENV N8N_SSL_ENABLED=false
ENV N8N_SECURE_COOKIE=false
ENV N8N_LOG_LEVEL=warn
ENV N8N_LOG_OUTPUT=console

EXPOSE 5678

CMD ["n8n", "start"]

# n8n/Dockerfile
# Versão leve usando a imagem oficial n8n como base.
# Mantém as melhores práticas e permite customizações se precisares de adicionar pacotes.

# FROM n8nio/n8n:latest

# Se precisares instalar adicionais (CLI, certificados ou utilitários), podes usar algo como:
# USER root
# RUN apk add --no-cache curl jq
# USER node

# Mantém o utilizador original da imagem
# Não sobrescrever CMD: o render.yaml usa "n8n start" como startCommand
