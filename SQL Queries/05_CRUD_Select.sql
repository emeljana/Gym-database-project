SELECT * FROM classes
WHERE start_time > CURRENT_TIMESTAMP;

SELECT m.name, c.class_name -- namnet på medlemmen som har bokar och på klassen som medlemmen har bokat.
FROM bookings b
JOIN members m ON b.member_id = m.member_id
JOIN classes c ON b.class_id = c.class_id; -- kopplar ihop bokningar med klasser där class_id är samma.

SELECT
    m.name,
    c.class_name
FROM bookings b
JOIN members m
  ON b.member_id = m.member_id
JOIN classes c
  ON b.class_id = c.class_id
WHERE c.class_name = 'Morning Yoga'
ORDER BY m.name;
