# OpenHands

## Objetivo

Agente de codificación autónomo (IDE + agente de IA) autoalojado. Recibe una
tarea en lenguaje natural y escribe/ejecuta código, corre comandos y edita
archivos dentro de sus propios contenedores "sandbox". Usa **LiteLLM**
(`docker/litellm`) como backend de modelos, igual que Open WebUI.

## ⚠️ Consideración de seguridad — leer antes de levantar

Este servicio monta `/var/run/docker.sock` dentro del contenedor. Esto es
**inherente a cómo funciona OpenHands** (necesita crear sus propios
contenedores sandbox para ejecutar código) y no es una opción configurable.
En la práctica, el contenedor `openhands` tiene control equivalente a root
sobre el Docker del host.

Por eso:
- No lo expongas fuera de la red interna/Tailscale.
- No le des tareas ni repos que no revisarías tú mismo.
- Trátalo con el mismo nivel de confianza que una sesión de terminal root en
  el servidor.

## Instalación

```bash
cd docker/openhands
docker compose up -d
```

El primer arranque descarga además la imagen "runtime" (el sandbox donde
corre el código) — puede tardar varios minutos y requiere acceso a internet
saliente desde el servidor.

## Variables de entorno (`.env`)

| Variable | Descripción |
|---|---|
| `TZ` | Zona horaria |
| `SANDBOX_USER_ID` | UID del host (1000) para que los archivos que crea el agente en `workspace/` queden con el dueño correcto |
| `LLM_MODEL` | `openai/claude-sonnet-5` — usa el alias definido en `docker/litellm/config/config.yaml`. Cambialo si prefieres otro `model_name` de ese archivo (ej. `openai/gpt-4o`) |
| `LLM_BASE_URL` | Apunta a LiteLLM (`http://litellm:4000`) |
| `LLM_API_KEY` | Reutiliza `LITELLM_MASTER_KEY` (ya centralizado en `lab/.env` para el proyecto `litellm`) |
| `GITHUB_TOKEN` | Opcional — para clonar/pushear repos privados. También se puede configurar después desde Settings en la UI |

No se agregaron variables nuevas a `lab/.env`: este servicio no tiene
credenciales propias, solo reutiliza `LITELLM_MASTER_KEY`.

## Estructura

```
openhands/
  docker-compose.yml
  .env
```

Sin `Dockerfile`: usa la imagen oficial `ghcr.io/all-hands-ai/openhands`,
pineada por digest. La imagen "runtime" (sandbox) la resuelve OpenHands
automáticamente según su propia versión — no se fija a mano para evitar
descoordinar versiones.

Datos persistentes:
- `../../data/openhands/state` → configuración y conversaciones (`/.openhands`)
- `../../data/openhands/workspace` → carpeta de trabajo del agente (`/opt/workspace_base`)

## Ejecución

- URL: http://100.70.250.3:3009 (o `localhost:3009` en el mismo equipo)
- Requiere `docker/litellm` corriendo para poder usar modelos.
