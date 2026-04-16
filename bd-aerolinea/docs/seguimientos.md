# Seguimiento Técnico – SGA

## Estado actual (15 Abril 2026 – Prueba supervisada)

| HU | Actividad | Estado | Commit |
|----|-----------|--------|--------|
| HU-001 | Análisis de 12 dominios, 79 tablas documentadas |  | `feat(HU-001): analisis dominios funcionales` |
| HU-002 | Estructura repo + ramas main/develop/qa |  | `feat(HU-002): estructura repositorio y ramas` |
| HU-003 | docker-compose.yml con PostgreSQL 15 + healthcheck |  | `feat(HU-003): contenedor postgresql` |
| HU-004 | Liquibase integrado en docker-compose con depends_on healthy |  | `feat(HU-004): integracion liquibase` |
| HU-005 | 12 changelogs por dominio + changelog-master.yaml completo |  | `feat(HU-005): changelogs por dominio` |
| HU-006 | Roles PostgreSQL (DCL) | 🔄 Pendiente | — |
| HU-007 | Scripts de datos de prueba | 🔄 Pendiente | — |
| HU-008 | 5 ADR documentados, backlog, plan de trabajo |  | `docs(HU-008): ADR y documentacion tecnica` |

## Decisiones tomadas

- Se usa `liquibase/liquibase:4.27` con versión fija para reproducibilidad.
- El `docker-compose.yml` usa `condition: service_healthy` para garantizar que Liquibase espere a PostgreSQL.
- Los changelogs de dominio se nombran con prefijo numérico para forzar orden de carga.
- El archivo oculto `.001_tables_abordaje.sql` fue renombrado a `001_tables_abordaje.sql`.
- Los índices de geografía tenían nombre inconsistente (`indexes` vs `indixes`), unificados a `indixes`.

## Pendientes desescolarizado

- Implementar `03_dcl/00_roles/` con roles de PostgreSQL (sga_admin, sga_operator, sga_sales, sga_audit).
- Poblar `02_dml/00_inserts/` con scripts de datos de prueba siguiendo `docs/plan_datos_prueba.md`.
- Validar ejecución completa con `docker compose up` y verificar las 79 tablas en la BD.
