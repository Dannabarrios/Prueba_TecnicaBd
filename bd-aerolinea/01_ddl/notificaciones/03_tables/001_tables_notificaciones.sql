-- ============================================
-- NOTIFICATIONS AND COMMUNICATIONS
-- ============================================

CREATE TABLE notification_channel (
    notification_channel_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    channel_code varchar(20) NOT NULL,
    channel_name varchar(80) NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uq_notification_channel_code UNIQUE (channel_code),
    CONSTRAINT uq_notification_channel_name UNIQUE (channel_name),
    CONSTRAINT ck_notification_channel_code CHECK (
        channel_code IN ('EMAIL', 'SMS', 'PUSH')
    )
);

CREATE TABLE notification_template (
    notification_template_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    notification_channel_id uuid NOT NULL 
        REFERENCES notification_channel(notification_channel_id),
    template_code varchar(50) NOT NULL,
    template_name varchar(120) NOT NULL,
    subject varchar(200),
    body_template text NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uq_notification_template_code UNIQUE (template_code)
);

CREATE TABLE notification_event (
    notification_event_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    notification_template_id uuid NOT NULL 
        REFERENCES notification_template(notification_template_id),
    reservation_id uuid 
        REFERENCES reservation(reservation_id),
    person_contact_id uuid 
        REFERENCES person_contact(person_contact_id),
    status_code varchar(20) NOT NULL DEFAULT 'PENDING',
    scheduled_at timestamptz NOT NULL DEFAULT now(),
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_notification_event_status CHECK (
        status_code IN ('PENDING', 'SENT', 'FAILED', 'CANCELLED')
    )
);

CREATE TABLE notification_log (
    notification_log_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    notification_event_id uuid NOT NULL 
        REFERENCES notification_event(notification_event_id),
    sent_at timestamptz NOT NULL DEFAULT now(),
    result_code varchar(20) NOT NULL,
    provider_response text,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_notification_log_result CHECK (
        result_code IN ('SUCCESS', 'FAILED', 'BOUNCED')
    )
);