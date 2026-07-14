# Streamlit

## Objetivo

Contenedor base para apps de datos/dashboards en Streamlit. Sirve como punto de
partida: reemplaza `app/app.py` (y agrega dependencias en `pyproject.toml`) por
tu propia app sin tocar el `Dockerfile` ni el `docker-compose.yml`.

## Instalación

```bash
cd docker/streamlit
docker compose up -d --build
```

## Variables de entorno (`.env`)

| Variable | Descripción |
|---|---|
| `TZ` | Zona horaria del contenedor |
| `STREAMLIT_PORT` | Puerto publicado en el host (por defecto `8501`, el default de Streamlit) |

Este servicio no requiere credenciales propias, por lo que no tiene entradas en
`lab/.env` central. Si la app que se agregue necesita secretos (API keys, DB,
etc.), deben centralizarse ahí siguiendo la misma convención que el resto de
`docker/*` (ver `lab/.env.example`).

## Estructura

```
streamlit/
  Dockerfile
  docker-compose.yml
  pyproject.toml
  uv.lock
  .env
  app/
    app.py       # código de la app (editable sin rebuild, montado como volumen)
```

Los datos persistentes de la app (si los hay) van en `../../data/streamlit`,
montado en `/app/data` dentro del contenedor.

## Ejecución

- URL: http://100.70.250.3:8501 (o `localhost:8501` en el mismo equipo)
- Sin login por defecto.
