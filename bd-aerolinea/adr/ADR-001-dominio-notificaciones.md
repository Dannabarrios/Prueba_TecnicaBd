# ADR-001: Incorporación del Dominio de Notificaciones y Comunicaciones

## Contexto
El SGA gestiona eventos críticos (cambios de vuelo, confirmaciones de reserva, alertas de pago) que actualmente no tienen un dominio de registro en el modelo. Los sistemas de aerolínea deben mantener trazabilidad de toda comunicación enviada al pasajero.

## Problema
No existe un mecanismo para registrar qué comunicaciones se han enviado a los pasajeros ni por qué canal, lo que impide auditoría, reintentos controlados y cumplimiento de SLA de notificación.

## Decisión
Crear el dominio **Notificaciones y Comunicaciones** con las siguientes tablas:
- `notification_channel` – canales disponibles (EMAIL, SMS, PUSH)
- `notification_template` – plantillas parametrizadas por tipo de evento
- `notification_event` – instancia de notificación por reserva o persona
- `notification_log` – registro de cada envío con estado y timestamp

## Justificación técnica
Las tablas se relacionan con `reservation`, `person_contact` y `user_account` sin modificar el modelo existente. Se usa UUID como PK (coherente con todo el modelo) y columna `status_code` con CHECK para estados válidos (`PENDING`, `SENT`, `FAILED`, `READ`). La separación en dominio propio permite escalar el servicio de notificaciones de forma independiente.

## Consecuencias / Impacto esperado
- Se agrega un dominio coherente sin romper el modelo existente.
- Se crea `01_ddl/notificaciones/` con su propio `changelog.yaml`.
- El `changelog-master.yaml` incluye el nuevo dominio al final.
- Se agrega HU-009 al backlog: "Implementar dominio de notificaciones".
