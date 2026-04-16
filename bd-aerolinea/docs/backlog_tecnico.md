# Backlog Técnico – SGA

Herramienta de seguimiento: GitHub Projects (tablero Kanban)

## Historias de Usuario

| ID | Historia | Prioridad | Sprint | Estado |
|----|----------|-----------|--------|--------|
| HU-001 | Identificar y documentar dominios funcionales del modelo existente | Alta | 1 |  Completada |
| HU-002 | Organizar estructura del repositorio y definir ramas develop, qa y main | Alta | 1 |  Completada |
| HU-003 | Contenerizar PostgreSQL para levantar la BD en entorno local | Alta | 1 |  Completada |
| HU-004 | Contenerizar Liquibase e integrarlo al proyecto | Alta | 1 |  Completada |
| HU-005 | Separar el DDL en changelogs organizados por dominio funcional | Alta | 2 |  Completada |
| HU-006 | Diseñar e implementar estrategia de roles y permisos diferenciados | Alta | 2 | 🔄 Pendiente |
| HU-007 | Construir plan de datos de prueba con orden de carga por dependencias | Media | 3 | 🔄 Pendiente |
| HU-008 | Documentar seguimiento técnico y decisiones arquitectónicas (ADR) | Media | 2 |  Completada |

## Dependencias

```
HU-001 → HU-002 → HU-003 → HU-004 → HU-005
                                       ↓
                               HU-006, HU-007, HU-008
```
