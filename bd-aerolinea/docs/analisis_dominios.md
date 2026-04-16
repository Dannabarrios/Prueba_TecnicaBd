# Análisis de Dominios Funcionales – SGA

El modelo `modelo_postgresql.sql` implementa un **Sistema de Gestión Aeronáutica (SGA)** con **12 dominios funcionales** y **79 tablas**. Todas las entidades usan UUID como PK generado con `gen_random_uuid()`.

## Dominios identificados

| # | Dominio | Tablas principales | Propósito |
|---|---------|-------------------|-----------|
| 01 | **Geografía y Referencia** | `time_zone`, `continent`, `country`, `state_province`, `city`, `district`, `address`, `currency` | Catálogo geográfico jerárquico y monedas. Base de aeropuertos, aerolíneas y personas. |
| 02 | **Aerolínea** | `airline` | Entidad central que opera vuelos, flota y programas de fidelización. |
| 03 | **Identidad** | `person_type`, `document_type`, `contact_type`, `person`, `person_document`, `person_contact` | Registro maestro de personas con documentos y contactos. |
| 04 | **Seguridad** | `user_status`, `security_role`, `security_permission`, `user_account`, `user_role`, `role_permission` | RBAC a nivel de aplicación: cuentas, roles y permisos. |
| 05 | **Clientes y Fidelización** | `customer_category`, `benefit_type`, `loyalty_program`, `loyalty_tier`, `customer`, `loyalty_account`, `loyalty_account_tier`, `miles_transaction`, `customer_benefit` | Clientes por aerolínea y programa completo de millas. |
| 06 | **Aeropuerto** | `airport`, `terminal`, `boarding_gate`, `runway`, `airport_regulation` | Infraestructura física: terminales, puertas, pistas y regulaciones. |
| 07 | **Aeronaves** | `aircraft_manufacturer`, `aircraft_model`, `cabin_class`, `aircraft`, `aircraft_cabin`, `aircraft_seat`, `maintenance_provider`, `maintenance_type`, `maintenance_event` | Flota con configuración de cabinas, asientos y mantenimiento. |
| 08 | **Operaciones de Vuelo** | `flight_status`, `delay_reason_type`, `flight`, `flight_segment`, `flight_delay` | Instancias de vuelo, segmentos de ruta y registro de retrasos. |
| 09 | **Ventas, Reservas y Tiquetes** | `reservation_status`, `sale_channel`, `fare_class`, `fare`, `ticket_status`, `reservation`, `reservation_passenger`, `sale`, `ticket`, `ticket_segment`, `seat_assignment`, `baggage` | Flujo: reserva → venta → tiquete → asiento → equipaje. |
| 10 | **Abordaje** | `boarding_group`, `check_in_status`, `check_in`, `boarding_pass`, `boarding_validation` | Check-in, emisión de pase de abordar y validación en puerta. |
| 11 | **Pagos** | `payment_status`, `payment_method`, `payment`, `payment_transaction`, `refund` | Pagos, transacciones con pasarela y devoluciones. |
| 12 | **Facturación** | `tax`, `exchange_rate`, `invoice_status`, `invoice`, `invoice_line` | Facturación fiscal con impuestos, tipos de cambio y líneas de detalle. |

## Relaciones clave entre dominios

- **`person`** es el núcleo de identidad: conecta con `user_account` (seguridad), `customer` (fidelización) y `reservation_passenger` (ventas).
- **`airline`** es el pivot central: referenciada por `aircraft`, `loyalty_program`, `fare` y `customer`.
- **`flight_segment`** es la entidad de mayor conectividad: referenciada por `ticket_segment`, `seat_assignment`, `check_in` y `flight_delay`.
- Cadena comercial: `reservation → reservation_passenger → sale → ticket → ticket_segment → seat_assignment / baggage`.
- Cadena de abordaje: `ticket_segment → check_in → boarding_pass → boarding_validation`.
- Cadena financiera: `sale → payment → payment_transaction / refund` y `sale → invoice → invoice_line`.
