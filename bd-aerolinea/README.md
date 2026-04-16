# SGA – Sistema de Gestión Aeronáutica

Base de datos PostgreSQL para un sistema aeronáutico completo. 12 dominios funcionales, 79 tablas, versionado con Liquibase y desplegable con Docker Compose.

## Levantar el entorno

```bash
# Primera vez o después de cambios en changelogs
docker compose up

# Parar sin borrar datos
docker compose down

# Resetear todo (borra la BD)
docker compose down -v
```

Liquibase aplica todos los changelogs automáticamente. Espera a que PostgreSQL esté listo gracias al `healthcheck` — ese era el bug que levantaba MySQL en vez de PostgreSQL.

## Estructura del proyecto

```
bd-aerolinea/
├── docker-compose.yml          ← PostgreSQL 15 + Liquibase 4.27
├── changelog-master.yaml       ← Orquesta los 12 dominios en orden
├── liquibase.properties        ← Conexión para uso local sin Docker
├── 01_ddl/                     ← DDL separado por dominio
│   ├── 00_extensions/
│   ├── geografia/
│   ├── aerolinea/
│   ├── identidad/
│   ├── seguridad/
│   ├── clientes/
│   ├── aeropuerto/
│   ├── aeronaves/
│   ├── operaciones_vuelo/
│   ├── ventas/
│   ├── abordaje/
│   ├── pagos/
│   └── facturacion/
│       ├── 03_tables/          ← CREATE TABLE
│       ├── 09_indixes/         ← CREATE INDEX
│       └── changelog.yaml
├── 02_dml/00_inserts/          ← Datos de prueba (pendiente HU-007)
├── 03_dcl/00_roles/            ← Roles PostgreSQL (pendiente HU-006)
├── adr/
│   ├── ADR-001-dominio-notificaciones.md
│   ├── ADR-002-roles-permisos-db.md
│   ├── ADR-003-liquibase-versionamiento.md
│   ├── ADR-004-estrategia-ramas.md
│   └── ADR-005-contenedorizacion-docker.md
└── docs/
    ├── analisis_dominios.md
    ├── backlog_tecnico.md
    ├── plan_datos_prueba.md
    └── seguimientos.md
```

## Ramas

| Rama | Uso |
|------|-----|
| `main` | Producción — solo merge desde `qa` |
| `qa` | Validación — solo merge desde `develop` |
| `develop` | Desarrollo activo |
| `feat-HU-XXX-desc` | Feature por historia de usuario |

## Dominios

| # | Dominio | Tablas principales |
|---|---------|-------------------|
| 01 | Geografía y Referencia | `time_zone`, `continent`, `country`, `state_province`, `city`, `district`, `address`, `currency` |
| 02 | Aerolínea | `airline` |
| 03 | Identidad | `person_type`, `document_type`, `contact_type`, `person`, `person_document`, `person_contact` |
| 04 | Seguridad | `user_status`, `security_role`, `security_permission`, `user_account`, `user_role`, `role_permission` |
| 05 | Clientes y Fidelización | `customer_category`, `benefit_type`, `loyalty_program`, `loyalty_tier`, `customer`, `loyalty_account`, `loyalty_account_tier`, `miles_transaction`, `customer_benefit` |
| 06 | Aeropuerto | `airport`, `terminal`, `boarding_gate`, `runway`, `airport_regulation` |
| 07 | Aeronaves | `aircraft_manufacturer`, `aircraft_model`, `cabin_class`, `aircraft`, `aircraft_cabin`, `aircraft_seat`, `maintenance_provider`, `maintenance_type`, `maintenance_event` |
| 08 | Operaciones de Vuelo | `flight_status`, `delay_reason_type`, `flight`, `flight_segment`, `flight_delay` |
| 09 | Ventas, Reservas y Tiquetes | `reservation_status`, `sale_channel`, `fare_class`, `fare`, `ticket_status`, `reservation`, `reservation_passenger`, `sale`, `ticket`, `ticket_segment`, `seat_assignment`, `baggage` |
| 10 | Abordaje | `boarding_group`, `check_in_status`, `check_in`, `boarding_pass`, `boarding_validation` |
| 11 | Pagos | `payment_status`, `payment_method`, `payment`, `payment_transaction`, `refund` |
| 12 | Facturación | `tax`, `exchange_rate`, `invoice_status`, `invoice`, `invoice_line` |
