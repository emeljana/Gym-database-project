SELECT
    b.booking_id,
    m.name AS member_name,
    c.class_name,
    c.start_time,
    b.status,
	m.email
FROM bookings b
JOIN members m
  ON b.member_id = m.member_id
JOIN classes c
  ON b.class_id = c.class_id
ORDER BY c.start_time, m.name;

UPDATE classes
SET capacity = 20
WHERE class_name = 'Morning Yoga'
  AND capacity <> 20;

UPDATE bookings b
SET status = 'cancelled'
FROM members m, classes c
WHERE b.member_id = m.member_id
  AND b.class_id = c.class_id
  AND m.email = 'lisa@mail.se'
  AND c.class_name = 'Morning Yoga'
  AND b.status <> 'cancelled';

SELECT b.status
FROM bookings b
JOIN members m ON b.member_id = m.member_id
JOIN classes c ON b.class_id = c.class_id
WHERE m.email = 'lisa@mail.se'
  AND c.class_name = 'Morning Yoga';





