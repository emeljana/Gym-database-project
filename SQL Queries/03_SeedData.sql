INSERT INTO members (name, email, social_nr, adress, telefon_nr)
VALUES 
('Lisa Berg', 'lisa@mail.se', '900101-1234', 'Stockholm', '0701111111'),
('Oskar Holm', 'oskar@mail.se', '890202-2345', 'Uppsala', '0702222222'),
('Emma Sjö', 'emma@mail.se', '920303-3456', 'Västerås', '0703333333'),
('Noah Ek', 'noah@mail.se', '910404-4567', 'Örebro', '0704444444'),
('Maja Lund', 'maja@mail.se', '930505-5678', 'Enköping', '0705555555');

INSERT INTO trainers (name, email, speciality) 
VALUES
('Anna Svensson', 'anna@fitness.se', 'Yoga'),
('Erik Nilsson', 'erik@fitness.se', 'Strength'),
('Maria Lind', 'maria@fitness.se', 'Pilates'),
('Johan Karlsson', 'johan@fitness.se', 'Cardio');

INSERT INTO membersship_plans (plan_name, price, duration) 
VALUES
('Basic', 299, 1),
('Standard', 799, 3),
('Premium', 1499, 6),
('Annual', 2499, 12);

INSERT INTO classes (class_name, start_time, capacity, trainer_id) 
VALUES
('Morning Yoga', '2026-02-01 08:00', 15, 1),
('Power Strength', '2026-02-01 10:00', 12, 2),
('Pilates Flow', '2026-02-02 09:00', 15, 3),
('HIIT Cardio', '2026-02-02 18:00', 20, 4),
('Evening Yoga', '2026-02-03 19:00', 15, 1);

INSERT INTO subscriptions (start_date, end_date, status, member_id, plan_id) VALUES
('2026-01-01', '2026-02-01', 'active', 1, 1),
('2026-01-01', '2026-04-01', 'active', 2, 2),
('2026-01-15', '2026-07-15', 'active', 3, 3),
('2026-01-20', '2027-01-20', 'active', 4, 4),
('2026-02-01', '2026-03-01', 'active', 5, 1);

INSERT INTO bookings (status, member_id, class_id) 
VALUES
('active', 1, 1),
('active', 2, 1),
('active', 3, 2),
('active', 4, 2),
('active', 5, 3),
('active', 4, 3),
('active', 5, 4),
('active', 3, 4),
('active', 1, 5);


