CREATE OR REPLACE VIEW MemberBookings AS
SELECT
    b.booking_id,
    b.member_id,
    c.class_id,
    c.class_name,
    c.start_time,
    b.status AS booking_status
FROM bookings b
JOIN classes c ON c.class_id = b.class_id
ORDER BY b.member_id, c.start_time DESC;

-- visa alla bokningar inom 14 dagar
SELECT *
FROM MemberBookings;

CREATE OR REPLACE FUNCTION CreateBooking(
    p_member_id INT, -- p = parameter
    p_class_id  INT
)
RETURNS INT - retunerar det nya booking_id
LANGUAGE plpgsql -- vilket språk funktionen är skriven i = PostgreSql procedurspråk
-- krävs när man använder variabler, BEGIN/END, skriver mer än ett SQL statment
AS $$ -- all kod mellan $$ markerar själva funktionkroppen, slipper citattecken inuti
DECLARE
    v_booking_id INT; -- deklarerar lokala variabler, skapar det nya id
BEGIN
    INSERT INTO bookings (member_id, class_id, status) -- skapar en ny bokning och använder parametrarna som skickades in
    VALUES (p_member_id, p_class_id, 'active')
    RETURNING booking_id INTO v_booking_id;
	-- hela kommande betyder --> ge mig det idet som skapades och spara det i variabeln 

    RETURN v_booking_id;
END; -- BEGIN/END jämför detta som metodkroppen i programmering
$$;


SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE (table_name IN ('payments','bookings') AND column_name = 'booking_id')
ORDER BY table_name;


ALTER TABLE payments
ALTER COLUMN booking_id TYPE integer;



