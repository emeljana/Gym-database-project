SELECT -- hur många bokningar per klass, enast klasser med fler eller lika med 2
    c.class_id,
    c.class_name,
    COUNT(*) AS booking_count
FROM bookings b
JOIN classes c ON b.class_id = c.class_id
GROUP BY c.class_id, c.class_name
HAVING COUNT(*) >= 2
ORDER BY booking_count DESC; -- descending

--CTE: "tillfällig tabell": 1
WITH class_occupancy AS (
    SELECT
        c.class_id,
        c.class_name,
        c.start_time,
        c.capacity,
        COUNT(b.booking_id) AS booked_spots--3: antal aktiva bokningar per klass
    FROM classes c --2
    LEFT JOIN bookings b -- får med alla klasser även om de har 0 bokningar
      ON b.class_id = c.class_id
     AND b.status = 'active' -- de som inte är active räknas inte med 
    GROUP BY c.class_id, c.class_name, c.start_time, c.capacity--4: grupperar per klass så COUNT räknas per klass
)
SELECT
    class_id,
    class_name,
    start_time,
    capacity,
    booked_spots,
    ROUND((booked_spots::numeric / NULLIF(capacity, 0)) * 100, 1) AS occupancy_percent
	-- "booked_spots::numeric": gör om de till decimal
	-- "NULLIF(capacity, 0": om capacity är 0 så ska den retunera NULL istället för 0, för man kan inte göra division med 0.
FROM class_occupancy
ORDER BY start_time; -- sorterar så att klasserna kommer i tidsordning

--Affärsfråga: Vilka klasser har låg beläggning (under40%) som bör ses över?

WITH class_occupancy AS (
    SELECT
        c.class_id,
        c.class_name,
        c.start_time,
        c.capacity,
        COUNT(b.booking_id) AS booked_spots
    FROM classes c
    LEFT JOIN bookings b
      ON b.class_id = c.class_id
     AND b.status = 'active'
    GROUP BY c.class_id, c.class_name, c.start_time, c.capacity
)
SELECT
    class_id,
    class_name,
    start_time,
    capacity,
    booked_spots,
    ROUND((booked_spots::numeric / NULLIF(capacity, 0)) * 100, 1) AS occupancy_percent
FROM class_occupancy
WHERE (booked_spots::numeric / NULLIF(capacity, 0)) < 0.40
ORDER BY occupancy_percent ASC, start_time;

SELECT
    c.class_id,
    c.class_name,
    b.booking_id,
    b.status
FROM classes c
LEFT JOIN bookings b ON b.class_id = c.class_id
WHERE c.class_name = 'Test Yoga Class';
-- Finns inga bokningar alls på Test Yga Class, så den hade kan kunnat se över eller kanske tillomed ta bort.


--Transaktion: boka ett pass och betala
-- Båda inserts måste funka, annars går inget igenom

CREATE TABLE IF NOT EXISTS payments (
    payment_id      BIGSERIAL PRIMARY KEY, -- skapar en sekvens, varje ny rad får ett unikt id
    booking_id      BIGINT NOT NULL, -- varje payment måste tillhöra en bokning
    amount          NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    payment_status  TEXT NOT NULL CHECK (payment_status IN ('paid', 'pending', 'failed', 'refunded')),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, -- timestamp med tidzon

    CONSTRAINT fk_payments_booking --CONSTRAINT: nu definerar jag en regel, sen namnet på regeln
        FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id) --“värdet i payments.booking_id måste finnas i bookings.booking_id”
        ON DELETE CASCADE -- om en bokning tas bort, då tas betalningen bort från samma id
);

CREATE INDEX IF NOT EXISTS idx_payments_booking_id
    ON payments (booking_id); --indexet byggs på payments.booking_id

BEGIN; -- startar en transaktion, alla ändringar är tillfälliga tills commit körs
-- kör ROLLBACK om något går fel

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
    40.00,
    'paid',
    CURRENT_TIMESTAMP
FROM new_booking;

COMMIT;

-- kolla att transaktionen funkade
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


