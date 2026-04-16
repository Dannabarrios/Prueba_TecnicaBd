# ADR-003: Implementación de Liquibase para Versionamiento del DDL

## Contexto
El modelo existe como un único script SQL monolítico (`modelo_postgresql.sql`). No hay mecanismo para aplicar cambios incrementales, rastrear qué versión está en cada entorno ni revertir cambios específicos.

## Problema
Sin versionamiento del DDL, cualquier cambio al modelo se aplica manualmente, generando divergencia entre entornos (local, QA, producción) y pérdida de trazabilidad histórica del esquema.

## Decisión
Adoptar **Liquibase 4.27** como herramienta de gestión de cambios del DDL:
- Un `changelog.yaml` por dominio funcional (12 changelogs).
- Un `changelog-master.yaml` que orquesta todos los dominios en orden de dependencias.
- Cada `changeSet` incluye `id` único, `author` y referencia al archivo SQL con `sqlFile`.
- Liquibase se ejecuta mediante contenedor Docker definido en `docker-compose.yml`.

## Justificación técnica
Liquibase soporta PostgreSQL nativamente, genera `DATABASECHANGELOG` y `DATABASECHANGELOGLOCK` para trazabilidad completa, permite rollback declarativo y es compatible con pipelines CI/CD. La versión fija `4.27` garantiza reproducibilidad.

## Consecuencias / Impacto esperado
- El script original se convierte en el estado inicial (baseline) versionado en Liquibase.
- Todo cambio futuro al DDL va en un nuevo `changeSet` — nunca se modifica un changeSet existente.
- La rama `develop` contiene changelogs en desarrollo; `main` solo recibe changelogs validados en QA.
