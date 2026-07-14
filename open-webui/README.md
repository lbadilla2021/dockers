# Open WebUI

## Objetivo

Interfaz de chat (tipo ChatGPT) autoalojada para hablar con los modelos
disponibles en el laboratorio. No se conecta directo a Anthropic/OpenAI: usa
**LiteLLM** (`docker/litellm`) como backend único vía API compatible con
OpenAI, así las API keys reales de los proveedores quedan solo en LiteLLM.

## Instalación

```bash
cd docker/open-webui
docker compose up -d
```

Requiere que `docker/litellm` esté corriendo para poder chatear (si está
apagado, Open WebUI igual levanta, pero no lista modelos).

## Variables de entorno (`.env`)

| Variable | Descripción |
|---|---|
| `TZ` | Zona horaria |
| `DATABASE_URL` | Postgres compartido (base `openwebui`, usuario dedicado) — password en `lab/.env` (`PG_OPENWEBUI_PASSWORD`) |
| `WEBUI_SECRET_KEY` | Firma de sesiones/JWT — en `lab/.env` (`OPENWEBUI_SECRET_KEY`) |
| `OPENAI_API_BASE_URL` | Apunta a LiteLLM (`http://litellm:4000/v1`) |
| `OPENAI_API_KEY` | Reutiliza `LITELLM_MASTER_KEY` (ya centralizado en `lab/.env` para el proyecto `litellm`) |
| `ENABLE_SIGNUP` | Permite auto-registro. El primer usuario creado siempre queda admin. Desactivar (`false`) después de crear tu cuenta |
| `WEBUI_NAME` | Nombre mostrado en la interfaz |

## Estructura

```
open-webui/
  docker-compose.yml
  .env
```

Sin `Dockerfile`: usa la imagen oficial `ghcr.io/open-webui/open-webui`,
pineada por digest para reproducibilidad. Datos persistentes (config, chats,
documentos de RAG) en `../../data/open-webui`.

## Ejecución

- URL: http://100.70.250.3:3008 (o `localhost:3008` en el mismo equipo)
- Primer acceso: crear cuenta (queda como admin automáticamente).
