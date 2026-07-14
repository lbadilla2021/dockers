# AnythingLLM

## Objetivo

Chat + RAG sobre documentos con soporte de "workspaces" y agentes. Usa
**LiteLLM** (`docker/litellm`) como backend de modelos (proveedor
`generic-openai`) y **Qdrant** (`docker/qdrant`) como base vectorial
compartida, en vez de su almacenamiento local por defecto (LanceDB).

## Instalación

```bash
cd docker/anythingllm
docker compose up -d
```

## Variables de entorno (`.env`)

| Variable | Descripción |
|---|---|
| `TZ` | Zona horaria |
| `JWT_SECRET` / `SIG_KEY` / `SIG_SALT` | Firma de sesión y cifrado de credenciales guardadas — en `lab/.env` (`ANYTHINGLLM_*`) |
| `LLM_PROVIDER` | `generic-openai`, para hablar con LiteLLM vía API compatible OpenAI |
| `GENERIC_OPEN_AI_BASE_PATH` | `http://litellm:4000/v1` |
| `GENERIC_OPEN_AI_MODEL_PREF` | `claude-sonnet-5` — alias definido en `docker/litellm/config/config.yaml`; cambialo si prefieres otro `model_name` de ese archivo |
| `GENERIC_OPEN_AI_API_KEY` | Reutiliza `LITELLM_MASTER_KEY` (ya centralizado para el proyecto `litellm`) |
| `VECTOR_DB` / `QDRANT_ENDPOINT` / `QDRANT_API_KEY` | Usa Qdrant compartido; `QDRANT_API_KEY` reutiliza el mismo valor ya centralizado para el proyecto `qdrant` |
| `EMBEDDING_ENGINE` | `native` — embeddings integradas, sin dependencias externas |

Secretos nuevos agregados a `lab/.env`: `ANYTHINGLLM_JWT_SECRET`,
`ANYTHINGLLM_SIG_KEY`, `ANYTHINGLLM_SIG_SALT`.

## Estructura

```
anythingllm/
  docker-compose.yml
  .env
```

Sin `Dockerfile`: usa la imagen oficial `mintplexlabs/anythingllm`, pineada
por digest. Datos persistentes (config, chats, workspaces, documentos) en
`../../data/anythingllm` → `/app/server/storage`.

## Ejecución

- URL: http://100.70.250.3:3010 (o `localhost:3010` en el mismo equipo)
- Primer acceso: asistente de configuración inicial en la UI (crea tu cuenta
  ahí, no requiere variables de entorno adicionales).
