# ADR-004: Estrategia de Versionamiento del Repositorio con Ramas develop, qa y main

## Contexto
El proyecto requiere un flujo de trabajo que permita desarrollo paralelo, validación en entorno controlado y despliegue estable, sin mezclar código en desarrollo con código validado.

## Problema
Sin una estrategia de ramas definida, los cambios al DDL, changelogs y configuración de Docker pueden llegar directamente a `main` sin revisión, generando inestabilidad en el modelo compartido del equipo.

## Decisión
Tres ramas permanentes:

| Rama | Propósito | Reglas |
|------|-----------|--------|
| `main` | Producción estable | Solo recibe merges desde `qa`. Protegida contra push directo. |
| `qa` | Validación | Recibe merges desde `develop`. Se valida el DDL completo con Liquibase. |
| `develop` | Desarrollo activo | Base para todas las feature branches. |
| `feat-HU-XXX-desc` | Feature por HU | Se crea desde `develop`, se integra por PR, se elimina tras merge. |

Convención de commits: `tipo(HU-XXX): descripción` — ej: `feat(HU-005): changelog dominio ventas`.

## Justificación técnica
Este flujo es compatible con GitFlow y GitHub Flow. La protección de ramas en `main` y `qa` garantiza que solo código revisado llega a entornos estables. Los commits referenciados a HU permiten trazabilidad completa.

## Consecuencias / Impacto esperado
- La rama `feat-evidencia-aprendizaje-14-04` documenta el estado durante la prueba supervisada.
- Los changelogs de Liquibase solo se aplican en QA y main después de validación en develop.
- Se debe configurar GitHub Branch Protection Rules en `main` y `qa`.
