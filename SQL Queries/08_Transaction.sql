--Transaktion:
BEGIN; -- startar en transaktion, alla ändringar är tillfälliga tills commit körs
-- kör ROLLBACK om något går fel
--jag gör ett medvetet fel med negativt belopp

-- skapar en tillfällig tabell/resultat
WITH new_booking AS (
    INSERT INTO bookings (member_id, class_id, status) -- skapar en ny bokning
    VALUES (2, 3, 'active')
    RETURNING booking_id
)
INSERT INTO payments (booking_id, amount, payment_status, created_at)
 -- använder select här istället för insert för booking_id finns inte förrän
 -- efter insert i booking, därför används select i detta fall då de kommer från en query
 -- values används när jag redan vet alla värden i förväg
 SELECT
    booking_id,
    -40.00,
    'paid',
    CURRENT_TIMESTAMP
FROM new_booking;

--förväntat error och transaktionen blir aborted
--kör ROLLBACK direkt efter error
ROLLBACK;

-- COMMIT;

-- kontroll: ingennu bokning har sparats från föregående kommando
SELECT
    b.booking_id,
    b.member_id,
    b.class_id,
    b.status,
    p.payment_id,
    p.amount,
    p.payment_status,
    p.created_at
FROM bookings b
JOIN payments p ON p.booking_id = b.booking_id
ORDER BY b.booking_id DESC
LIMIT 5;


