DELETE FROM bookings b -- bokningar måste raderas först eftersom den har FK till members och classes
-- om en bokning finns till medlemen får inte medlemen eller klassen tas bort.
-- kopplingstabell ska därför bort först.
USING members m, classes c
WHERE b.member_id = m.member_id
  AND b.class_id = c.class_id
  AND m.email = 'lisa@mail.se'
  AND c.class_name = 'Morning Yoga';

  SELECT -- kollar att bokningen är borta
    b.booking_id,
    m.name,
    c.class_name,
    b.status
FROM bookings b
JOIN members m
  ON b.member_id = m.member_id
JOIN classes c
  ON b.class_id = c.class_id
WHERE m.email = 'lisa@mail.se'
  AND c.class_name = 'Morning Yoga';

SELECT -- kolalr vilka bokningar som finns fler i klassen
    b.booking_id,
    m.name,
    m.email,
    b.status
FROM bookings b
JOIN members m ON b.member_id = m.member_id
WHERE b.class_id = 1;

 DELETE FROM classes
WHERE class_name = 'Morning Yoga';

DELETE FROM bookings -- radera alla bokningar från klassen
WHERE class_id = 1;

DELETE FROM classes -- radera klassen
WHERE class_id = 1;





