CREATE ROLE trainer;

CREATE VIEW class_participants AS
SELECT
    c.class_id,
    c.class_name,
    m.member_id,
    m.name AS member_name
FROM classes c
JOIN bookings b ON b.class_id = c.class_id
JOIN members m ON m.member_id = b.member_id;

SELECT * FROM class_participants;

GRANT USAGE ON SCHEMA public TO trainer;
GRANT SELECT ON class_participants TO trainer;

CREATE USER trainer_anna
WITH PASSWORD 'anna123';

GRANT trainer TO trainer_anna;



