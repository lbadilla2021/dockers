-- Bases y roles dedicados para los servicios que reutilizan este Postgres compartido.
-- Se ejecuta automáticamente solo en una inicialización nueva (volumen de datos vacío).

CREATE USER langfuse WITH PASSWORD 'U6kWMHlvcb2ScIOXQdHPH5LOklJZgnpY';
CREATE DATABASE langfuse OWNER langfuse;

CREATE USER metabase WITH PASSWORD '0oDf7h26UiZggKgJd1VOFneb5N2b7z3D';
CREATE DATABASE metabase OWNER metabase;

CREATE USER litellm WITH PASSWORD 'yVvLKeFWgzAlgSWAMsFfiYLrNizCpS';
CREATE DATABASE litellm OWNER litellm;

CREATE USER flowise WITH PASSWORD 'C3uY8Q9CQ4fKdkyeI9sCm36xRD0DI47';
CREATE DATABASE flowise OWNER flowise;

CREATE USER zammad WITH PASSWORD 'iCD7etACn51MJaak9uIQst44iamaiT7';
CREATE DATABASE zammad OWNER zammad;

CREATE USER paperless WITH PASSWORD 'rpCiyaj8R0soz5ZLDUgjn69mchiwlPrt';
CREATE DATABASE paperless OWNER paperless;

CREATE USER documenso WITH PASSWORD 'c5l5XIecWTSMdQeekFdLLVPg6fK8Sddn';
CREATE DATABASE documenso OWNER documenso;

CREATE USER directus WITH PASSWORD 'tbWNlKamDFFJUJs5OKZPJaVKBxWLmuLR';
CREATE DATABASE directus OWNER directus;
