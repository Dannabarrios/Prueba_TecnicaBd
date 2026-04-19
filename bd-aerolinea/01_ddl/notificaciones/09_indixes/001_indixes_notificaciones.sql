-- INDEXES: notificaciones
CREATE INDEX idx_notification_template_channel_id 
    ON notification_template(notification_channel_id);
CREATE INDEX idx_notification_event_template_id 
    ON notification_event(notification_template_id);
CREATE INDEX idx_notification_event_reservation_id 
    ON notification_event(reservation_id);
CREATE INDEX idx_notification_event_status 
    ON notification_event(status_code);
CREATE INDEX idx_notification_log_event_id 
    ON notification_log(notification_event_id);