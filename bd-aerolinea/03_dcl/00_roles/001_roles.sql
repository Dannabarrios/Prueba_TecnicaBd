-- ============================================
-- ROLES DE BASE DE DATOS
-- ============================================

-- Rol administrador: solo para Liquibase
CREATE ROLE sga_admin NOLOGIN;

-- Rol operaciones: gestiona vuelos y abordaje
CREATE ROLE sga_operator NOLOGIN;

-- Rol ventas: gestiona reservas, tiquetes y pagos
CREATE ROLE sga_sales NOLOGIN;

-- Rol auditoría: solo lectura, sin modificar nada
CREATE ROLE sga_audit NOLOGIN;

-- ============================================
-- PERMISOS sga_operator
-- ============================================
GRANT SELECT, INSERT, UPDATE ON
    flight,
    flight_segment,
    flight_delay,
    check_in,
    boarding_pass,
    boarding_validation
TO sga_operator;

GRANT SELECT ON
    airport, terminal, boarding_gate,
    aircraft, aircraft_cabin, aircraft_seat,
    flight_status, delay_reason_type
TO sga_operator;

-- ============================================
-- PERMISOS sga_sales
-- ============================================
GRANT SELECT, INSERT, UPDATE ON
    reservation,
    reservation_passenger,
    sale,
    ticket,
    ticket_segment,
    seat_assignment,
    baggage,
    payment,
    payment_transaction,
    refund,
    invoice,
    invoice_line,
    notification_event,
    notification_log
TO sga_sales;

GRANT SELECT ON
    fare, fare_class, cabin_class,
    reservation_status, sale_channel,
    ticket_status, payment_status,
    payment_method, invoice_status, tax
TO sga_sales;

-- ============================================
-- PERMISOS sga_audit (solo lectura en todo)
-- ============================================
GRANT SELECT ON ALL TABLES IN SCHEMA public TO sga_audit;

-- ============================================
-- PERMISOS sga_admin (control total)
-- ============================================
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sga_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sga_admin;