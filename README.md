# Servicios del laboratorio

Índice de todos los servicios definidos en `docker/`. Cada carpeta tiene su propio
`docker-compose.yml` (y `.env` cuando aplica) siguiendo el estándar de CODEX.md:
un servicio = una carpeta, datos siempre en `../../data/<servicio>`, red compartida
`lab-network`, credenciales solo en `.env` (nunca en este documento).

Las URLs asumen acceso vía Tailscale (`100.70.250.3`); reemplaza por `localhost`
si accedes desde el mismo equipo.

## Índice

| Servicio | Carpeta | URL | Login |
|---|---|---|---|
| Uptime Kuma | `kuma/` | http://100.70.250.3:3001 | crear cuenta en el primer acceso |
| n8n | `n8n/` | http://100.70.250.3:5678 | crear cuenta owner en el primer acceso |
| Odoo 19 | `odoo19/` | http://100.70.250.3:8069 | crear base + admin en el primer acceso; master password en `config/odoo.conf` |
| PostgreSQL | `postgres/` | interno (`postgres:5432`) | usuario/clave en `.env` |
| Redis | `redis/` | interno (`redis:6379`) | clave en `.env` (`REDIS_PASSWORD`) |
| Portainer | `portainer/` | https://100.70.250.3:9443 | crear cuenta admin en el primer acceso |
| Qdrant | `qdrant/` | http://100.70.250.3:6333 | header `api-key` con el valor de `.env` (`QDRANT_API_KEY`) |
| MinIO | `minio/` | http://100.70.250.3:9001 (consola) / :9002 (API) | usuario/clave en `.env` (`MINIO_ROOT_USER` / `MINIO_ROOT_PASSWORD`) |
| Langfuse | `langfuse/` | http://100.70.250.3:3000 | email/clave en `.env` (`LANGFUSE_INIT_USER_EMAIL` / `LANGFUSE_INIT_USER_PASSWORD`) |
| Flowise | `flowise/` | http://100.70.250.3:3002 | usuario/clave en `.env` (`FLOWISE_USERNAME` / `FLOWISE_PASSWORD`) |
| LiteLLM | `litellm/` | http://100.70.250.3:4000 | Bearer token = `LITELLM_MASTER_KEY` en `.env` |
| Vaultwarden | `vaultwarden/` | http://100.70.250.3:8081 | crear cuenta en el primer acceso (desactivar `SIGNUPS_ALLOWED` después) |
| Grafana | `monitoring/` | http://100.70.250.3:3003 | usuario/clave en `.env` (`GF_SECURITY_ADMIN_USER` / `GF_SECURITY_ADMIN_PASSWORD`) |
| Prometheus | `monitoring/` | http://100.70.250.3:9090 | sin login |
| Metabase | `metabase/` | http://100.70.250.3:3004 | crear cuenta admin en el primer acceso |
| SearXNG | `searxng/` | http://100.70.250.3:8080 | sin login |
| Zammad | `zammad/` | http://100.70.250.3:8082 | crear cuenta admin en el primer acceso |
| Documenso | `documenso/` | http://100.70.250.3:3005 | crear cuenta en el primer acceso |
| Formbricks | `formbricks/` | http://100.70.250.3:3006 | crear cuenta en el primer acceso |
| Chatwoot | `chatwoot/` | http://100.70.250.3:3007 | crear cuenta en el primer acceso |
| Paperless-ngx | `paperless/` | http://100.70.250.3:8000 | usuario/clave en `.env` (`PAPERLESS_ADMIN_USER` / `PAPERLESS_ADMIN_PASSWORD`) |
| Directus | `directus/` | http://100.70.250.3:8055 | usuario/clave en `.env` (`ADMIN_EMAIL` / `ADMIN_PASSWORD`) |
| Streamlit | `streamlit/` | http://100.70.250.3:8501 | sin login |

No incluido: **Cal.com** — su distribución de self-host (`cal.diy`) ya no publica una imagen
Docker fija descargable; requiere clonar y compilar el monorepo completo. Se dejó fuera
para no depender de un build frágil; si más adelante quieres agendamiento embebible,
evaluar alternativas con imagen fija (p. ej. Easy!Appointments).

---

## Qué hace cada servicio

**Uptime Kuma** — monitoreo de disponibilidad (uptime) de todos los servicios y sitios del laboratorio, con alertas.

**n8n** — motor de automatizaciones low-code (workflows), conecta APIs, bases de datos y servicios entre sí.

**Odoo 19** — ERP: contabilidad, RRHH, inventario y demás módulos de gestión para Apex SpA y clientes.

**PostgreSQL** — base de datos relacional compartida. Aloja la base propia de Odoo y las bases dedicadas de Langfuse, Metabase, LiteLLM y Flowise.

**Redis** — caché y almacenamiento en memoria compartido; usado por n8n y por la cola de trabajos de Langfuse.

**Portainer** — panel de administración visual de Docker: ver, iniciar/detener y depurar todos los contenedores del laboratorio.

**Qdrant** — base de datos vectorial para memoria y RAG de agentes de IA (embeddings).

**MinIO** — almacenamiento de objetos compatible con S3; guarda los eventos/medios de Langfuse y sirve como bucket general para backups o datasets.

**Langfuse** — observabilidad y trazabilidad de LLMs/agentes: registra prompts, llamadas a herramientas, tokens, costo y latencia de cada ejecución.

**Flowise** — builder visual (drag-and-drop) para construir agentes y flujos LLM con memoria y herramientas, sin escribir todo el código a mano.

**LiteLLM** — gateway único para hablar con distintos proveedores de modelos (Anthropic, OpenAI, Ollama, etc.) con la misma API, manejo centralizado de keys y control de costos.

**Vaultwarden** — gestor de contraseñas y secretos autoalojado (compatible con clientes Bitwarden).

**Grafana + Prometheus** — stack de métricas de infraestructura: Prometheus recolecta (vía `node-exporter` y `cadvisor`) uso de CPU/RAM/disco del servidor y de cada contenedor; Grafana lo visualiza en dashboards.

**Metabase** — Business Intelligence: dashboards y reportes sobre los datos en Postgres/Odoo sin escribir SQL.

**SearXNG** — motor de búsqueda propio (metabuscador), útil como herramienta de "búsqueda web" para agentes sin depender de APIs de terceros de pago.

**Zammad** — mesa de ayuda interna (tickets, SLA, base de conocimiento) para soporte técnico y atención de clientes de Apex.

**Documenso** — firma electrónica de documentos (alternativa a DocuSign). Usa un certificado autofirmado (`certs/cert.p12`) válido solo para pruebas internas; para firmas con validez legal ante terceros hay que reemplazarlo por un certificado real.

**Formbricks** — encuestas y People Analytics (clima laboral, eNPS, onboarding) con analítica propia. Es el stack más pesado del laboratorio: además de Postgres (con `pgvector`) incluye un servicio "Hub" y un motor analítico Cube.js dedicados.

**Chatwoot** — chat en vivo para sitios web + bandeja unificada de WhatsApp/Instagram; atención al cliente omnicanal (distinto de Zammad, que es soporte interno con tickets). Usa Postgres propio con `pgvector` para las funciones de IA (Captain).

**Paperless-ngx** — digitalización documental con OCR (configurado en español): ingesta boletas, contratos y facturas, los indexa y los deja buscables.

**Directus** — CMS headless sobre Postgres: panel de administración de contenido para sitios web sin depender de un desarrollador para cada cambio.

**Streamlit** — contenedor base para dashboards y apps de datos en Python; punto de partida para levantar apps propias (visualización, prototipos de IA, herramientas internas) sin montar infraestructura desde cero.
# dockers
