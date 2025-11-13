# ==========================================================
# DOCKERFILE - n8n (Render Free Tier Otimizado)
# ==========================================================
FROM n8nio/n8n:latest

WORKDIR /data

# ===============================
# CONFIGURAÇÕES ESSENCIAIS
# ===============================
ENV GENERIC_TIMEZONE=Africa/Luanda
ENV NODE_ENV=production

# Limite seguro de memória para Render Free Tier (512 MB total)
ENV NODE_OPTIONS=--max-old-space-size=320

# ===============================
# DESATIVAR FUNCIONALIDADES PESADAS
# ===============================
ENV N8N_RUNNERS_ENABLED=false
ENV N8N_TEMPLATES_ENABLED=false
ENV N8N_PERSONALIZATION_ENABLED=false
ENV N8N_METRICS=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false
ENV N8N_HIRING_BANNER_DISABLED=true
ENV N8N_PRUNE_DATA=true
ENV N8N_PRUNE_DATA_MAX_AGE=168

# ===============================
# EXECUÇÕES — salvar só o necessário
# ===============================
ENV EXECUTIONS_DATA_SAVE_ON_SUCCESS=none
ENV EXECUTIONS_DATA_SAVE_ON_ERROR=all
ENV EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=false
ENV EXECUTIONS_TIMEOUT=600
ENV EXECUTIONS_TIMEOUT_RETRY=false
ENV EXECUTIONS_PROCESS=main

# ===============================
# SEGURANÇA E LOGS
# ===============================
ENV N8N_SSL_ENABLED=false
ENV N8N_SECURE_COOKIE=false
ENV N8N_LOG_LEVEL=warn
ENV N8N_LOG_OUTPUT=console
ENV EXECUTIONS_PROCESS=main

# ===============================
# PORTA
# ===============================
EXPOSE 5678

CMD ["n8n", "start"]
