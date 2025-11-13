# ==========================================================
# DOCKERFILE - n8n (Render Free Tier)
# ==========================================================
FROM n8nio/n8n:latest

WORKDIR /data

ENV GENERIC_TIMEZONE=Africa/Luanda
ENV NODE_ENV=production
ENV NODE_OPTIONS="--max-old-space-size=384"

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
