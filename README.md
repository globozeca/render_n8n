# zecaia-n8n-evolution

Deploy rápido para **Render (Free Tier)** com n8n + Evolution API + PostgreSQL + Redis + Supabase integration.
Este repositório foi gerado para o utilizador Edson (zecaia) e contém tudo o que precisa para deploy automático via render.yaml.

## Conteúdo
- `render.yaml` - blueprint para Render (cria serviços e bases de dados)
- `n8n/` - Dockerfile e .env.example para n8n
- `evolution-api/` - Dockerfile, server.js, package.json e .env.example
- `README.md` - instruções detalhadas

## Deploy no Render (passos rápidos)
1. Cria um repositório no GitHub e faz push deste projecto.
2. Em Render, vai a **Blueprints → New + → From Blueprint** e liga o repositório.
3. Após o deploy automático, preenche as variáveis sensíveis no painel do Render:
   - `N8N_ENCRYPTION_KEY`
   - `N8N_BASIC_AUTH_PASSWORD`
   - `SUPABASE_KEY`
   - `OPENAI_API_KEY` (opcional)
   - `API_KEY` (Evolution)
4. Espera o Render criar os serviços e obter as URLs públicas.

## Notas e boas práticas (Free Tier)
- Render suspende containers gratuitos após ~15 minutos de inatividade; **não** guardes ficheiros no disco local.
- Usa PostgreSQL e Redis do Render para persistência de dados.
- Usa Supabase Storage para ficheiros (imagens/áudios).
- Faz exports regulares dos workflows do n8n (JSON).

## Testes Locais
- Para testar localmente, instala dependências na pasta `evolution-api`:
  ```bash
  cd evolution-api
  npm install
  node server.js
  ```
- Para testar n8n localmente, podes usar a imagem oficial:
  ```bash
  docker run -it --rm -p 5678:5678 -e GENERIC_TIMEZONE=Africa/Luanda n8nio/n8n:latest
  ```

## Licença
MIT
