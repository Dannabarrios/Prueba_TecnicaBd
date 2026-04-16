# ADR-002: Diseño de Roles y Permisos Diferenciados en Base de Datos (RBAC)

## Contexto
El modelo ya incluye tablas de seguridad (`security_role`, `security_permission`, `user_role`, `role_permission`) que implementan RBAC a nivel de aplicación. Sin embargo, no existe una estrategia definida para los roles de base de datos PostgreSQL que controlen el acceso directo a los objetos del esquema.

## Problema
Cualquier conexión a la base de datos puede ejecutar DDL o DML sin restricción, lo que representa un riesgo de seguridad crítico en entornos de QA y producción. La ausencia de roles de BD hace imposible aplicar el principio de mínimo privilegio.

## Decisión
Definir cuatro roles de PostgreSQL en `03_dcl/00_roles/`:

| Rol | Permisos |
|-----|----------|
| `sga_admin` | DDL + DML completo — solo para migraciones Liquibase |
| `sga_operator` | SELECT, INSERT, UPDATE en tablas operacionales (vuelos, abordaje) |
| `sga_sales` | SELECT, INSERT, UPDATE en tablas de ventas y reservas |
| `sga_audit` | Solo SELECT en todas las tablas — sin modificación |

## Justificación técnica
Los roles se crean con `CREATE ROLE ... NOLOGIN` (grupos) y se asignan con `SET ROLE` en conexiones. Los GRANT/REVOKE se versionan en Liquibase mediante un changeSet en el changelog de seguridad. Este patrón es nativo de PostgreSQL, sin extensiones, y compatible con herramientas de monitoreo.

## Consecuencias / Impacto esperado
- Se cierra la brecha entre el RBAC de aplicación y el RBAC de base de datos.
- Las credenciales de cada rol se documentan en `.env.example` (nunca en el repo).
- El rol `sga_admin` solo debe usarse desde el contenedor de Liquibase.
