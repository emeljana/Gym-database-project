INSERT INTO members (name, email, social_nr, adress, telefon_nr)
VALUES 
('Emelie Hälgh', 'emelie@gmail.com', '999999-1234', 'Göteborgsvägen 12', '0701234123' )
ON CONFLICT (email) DO NOTHING;

INSERT INTO classes (class_name, start_time, capacity, trainer_id)
VALUES ('Test Yoga Class', '2026-03-01 10:00', 15, 1);

INSERT INTO bookings (status, member_id, class_id)
SELECT
    'active',
    m.member_id,
    c.class_id
FROM members m -- tabellnamn
JOIN classes c -- kopplar ihop members och classes (enbart en logisk koppling i frågan)
  ON c.class_name = 'Morning Yoga' -- join-villkor: välj enbart denna klass, ett kontrollerad join
WHERE m.email = 'maja@mail.se'
ON CONFLICT (member_id, class_id) DO NOTHING;
