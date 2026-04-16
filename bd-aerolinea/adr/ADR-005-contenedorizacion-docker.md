# ADR-005: Estrategia de Contenerización con Docker Compose para PostgreSQL y Liquibase

## Contexto
El proyecto debe poder ejecutarse en cualquier máquina sin dependencia de instalaciones locales de PostgreSQL o Liquibase. La variabilidad de entornos (Windows, Linux, macOS) genera inconsistencias en la ejecución del modelo.

## Problema
La falta de un entorno reproducible provoca que el modelo funcione en algunas máquinas y no en otras. La instalación manual de PostgreSQL 15 y Liquibase es propensa a errores de versión y configuración.

## Decisión
`docker-compose.yml` con dos servicios:

```yaml
postgres:          # postgres:15 con healthcheck pg_isready
liquibase:         # liquibase/liquibase:4.27 con depends_on: condition: service_healthy
```

El `healthcheck` en postgres es crítico: garantiza que Liquibase espere hasta que la BD esté lista antes de intentar conectarse. Sin esto, Liquibase falla inmediatamente porque postgres aún está inicializando.

Credenciales externalizadas en `.env` (nunca en el repositorio — se incluye `.env.example`).

## Justificación técnica
Docker Compose es el estándar de facto para orquestación en desarrollo local. `postgres:15` es imagen oficial y liviana. El `healthcheck` con `pg_isready` es el mecanismo correcto para detectar disponibilidad de PostgreSQL. La dependencia `condition: service_healthy` (en lugar del simple `depends_on: - postgres`) es lo que resuelve el problema de race condition que causaba que Liquibase levantara MySQL o fallara.

## Consecuencias / Impacto esperado
- Todo el equipo levanta el entorno con: `docker compose up`
- Los datos persisten entre reinicios gracias al volumen nombrado `postgres_data`.
- Para resetear completamente: `docker compose down -v`
- El pipeline CI/CD puede reutilizar la misma configuración ajustando variables de entorno.
