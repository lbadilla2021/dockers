# Temporal

## Objetivo

Motor de orquestación de workflows durables (retries, timers, sagas, cron)
para automatizaciones y procesos de negocio que necesitan sobrevivir
reinicios/fallos — complementa a n8n (low-code) para casos donde se necesita
código real con estado persistente y garantías de ejecución.

Basado en el `docker-compose-postgres.yml` oficial
(`temporalio/samples-server`), adaptado para reusar el Postgres compartido
del lab en vez de un Postgres dedicado.

## Instalación

```bash
cd docker/temporal
docker compose up -d
```

Servicios:
- `temporal-admin-tools`: un solo uso, aplica el esquema SQL. Termina y queda `Exited (0)` — es lo esperado.
- `temporal`: el server (frontend/history/matching/worker en un solo proceso).
- `temporal-create-namespace`: un solo uso, crea el namespace `default`. Idempotente, también termina `Exited (0)`.
- `temporal-ui`: interfaz web.

## Variables de entorno (`.env`)

| Variable | Descripción |
|---|---|
| `TZ` | Zona horaria |
| `POSTGRES_SEEDS` | Host del Postgres compartido (`postgres`) |
| `POSTGRES_USER` / `POSTGRES_PWD` / `SQL_PASSWORD` | Usuario dedicado `temporal` — password en `lab/.env` (`PG_TEMPORAL_PASSWORD`) |

Temporal usa **dos bases** en el Postgres compartido: `temporal` (estado) y
`temporal_visibility` (búsqueda/listado de workflows), ambas creadas en
`docker/postgres/init/01-app-databases.sql` con el usuario dedicado
`temporal`. El esquema interno de tablas lo crea `temporal-admin-tools` al
arrancar (no `psql`), por eso el script `scripts/setup-postgres.sh` está
adaptado del oficial: se salta el paso `create database` (ya existen) y solo
corre `setup-schema`/`update-schema`.

## Estructura

```
temporal/
  docker-compose.yml
  .env
  scripts/
    setup-postgres.sh      # adaptado del oficial (sin "create database")
    create-namespace.sh    # igual al oficial, idempotente
  dynamicconfig/
    development-sql.yaml   # config de dev/lab (no usar tal cual en prod real)
```

Sin `Dockerfile`: imágenes oficiales `temporalio/server`,
`temporalio/admin-tools` y `temporalio/ui`, pineadas a la versión `1.31.0`
(`2.49.1` para la UI).

## Ejecución

- UI: http://100.70.250.3:8083 (o `localhost:8083`), sin login.
- gRPC frontend (para SDKs de Temporal): `100.70.250.3:7233`.
- Namespace por defecto: `default`.

## Nota sobre reinicios

Si algún día cambias el password de `temporal` en `lab/.env`, el esquema ya
está creado — no hace falta re-correr `setup-postgres.sh` (fallará si lo
haces, el esquema ya existe). Solo actualiza el password con `ALTER USER`
en Postgres y en `lab/.env`.
