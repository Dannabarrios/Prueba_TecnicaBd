# Plan de Datos de Prueba – SGA

Los INSERT deben ejecutarse en este orden exacto para respetar las claves foráneas.

## Orden de inserción

| Paso | Dominio | Tablas | Depende de |
|------|---------|--------|-----------|
| 1 | Geografía | `time_zone`, `continent`, `currency` | — |
| 2 | Geografía | `country` | `continent` |
| 3 | Geografía | `state_province` | `country` |
| 4 | Geografía | `city` | `state_province`, `time_zone` |
| 5 | Geografía | `district` | `city` |
| 6 | Geografía | `address` | `district` |
| 7 | Aerolínea | `airline` | `country` |
| 8 | Identidad | `person_type`, `document_type`, `contact_type` | — |
| 9 | Identidad | `person` | `person_type`, `country` |
| 10 | Identidad | `person_document`, `person_contact` | `person` |
| 11 | Seguridad | `user_status`, `security_role`, `security_permission` | — |
| 12 | Seguridad | `user_account`, `user_role`, `role_permission` | `person`, `user_status`, `security_role` |
| 13 | Clientes | `customer_category`, `benefit_type` | — |
| 14 | Clientes | `customer` | `airline`, `person` |
| 15 | Clientes | `loyalty_program`, `loyalty_tier` | `airline`, `currency` |
| 16 | Clientes | `loyalty_account`, `loyalty_account_tier`, `miles_transaction` | `customer`, `loyalty_program` |
| 17 | Aeropuerto | `airport` | `address` |
| 18 | Aeropuerto | `terminal`, `runway`, `airport_regulation` | `airport` |
| 19 | Aeropuerto | `boarding_gate` | `terminal` |
| 20 | Aeronaves | `aircraft_manufacturer`, `aircraft_model`, `cabin_class`, `maintenance_type` | — |
| 21 | Aeronaves | `aircraft` | `airline`, `aircraft_model` |
| 22 | Aeronaves | `aircraft_cabin`, `maintenance_event` | `aircraft`, `cabin_class` |
| 23 | Aeronaves | `aircraft_seat` | `aircraft_cabin` |
| 24 | Operaciones | `flight_status`, `delay_reason_type` | — |
| 25 | Operaciones | `flight` | `airline`, `aircraft`, `flight_status` |
| 26 | Operaciones | `flight_segment` | `flight`, `airport` |
| 27 | Ventas | `reservation_status`, `sale_channel`, `ticket_status` | — |
| 28 | Ventas | `fare_class`, `fare` | `cabin_class`, `airline`, `airport`, `currency` |
| 29 | Ventas | `reservation` | `customer`, `reservation_status`, `sale_channel` |
| 30 | Ventas | `reservation_passenger` | `reservation`, `person` |
| 31 | Ventas | `sale` | `reservation`, `currency` |
| 32 | Ventas | `ticket` | `sale`, `reservation_passenger`, `fare`, `ticket_status` |
| 33 | Ventas | `ticket_segment` | `ticket`, `flight_segment` |
| 34 | Ventas | `seat_assignment`, `baggage` | `ticket_segment`, `aircraft_seat` |
| 35 | Abordaje | `boarding_group`, `check_in_status` | — |
| 36 | Abordaje | `check_in` | `ticket_segment`, `check_in_status`, `user_account` |
| 37 | Abordaje | `boarding_pass` | `check_in` |
| 38 | Abordaje | `boarding_validation` | `boarding_pass`, `boarding_gate`, `user_account` |
| 39 | Pagos | `payment_status`, `payment_method` | — |
| 40 | Pagos | `payment`, `payment_transaction`, `refund` | `sale`, `payment_status`, `payment_method` |
| 41 | Facturación | `tax`, `invoice_status`, `exchange_rate` | `currency` |
| 42 | Facturación | `invoice`, `invoice_line` | `sale`, `invoice_status`, `currency`, `tax` |

## Criterios de validación

- Mínimo 3 registros por tabla de catálogo (tipos, estados, categorías).
- Al menos 1 vuelo completo end-to-end: `airline → aircraft → flight → flight_segment → reservation → ticket → check_in → boarding_pass`.
- Al menos 1 ciclo financiero completo: `sale → payment → payment_transaction → invoice → invoice_line`.
- Probar constraints CHECK con datos inválidos (fechas invertidas, códigos fuera de rango) y verificar rechazo.
