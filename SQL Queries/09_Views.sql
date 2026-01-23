--skapar tabell för alla klasser kommande 14 dagar
CREATE OR REPLACE VIEW NextWeekSchedule AS
SELECT
    c.class_id,
    c.class_name,
    c.start_time,
    c.capacity,
    COUNT(b.booking_id) AS booked_spots,
    ROUND(
        (COUNT(b.booking_id)::numeric / NULLIF(c.capacity, 0)) * 100,
        1
    ) AS occupancy_percent
FROM classes c
LEFT JOIN bookings b
    ON b.class_id = c.class_id
   AND b.status = 'active'
WHERE c.start_time >= CURRENT_DATE
  AND c.start_time < CURRENT_DATE + INTERVAL '14 days'
GROUP BY
    c.class_id,
    c.class_name,
    c.start_time,
    c.capacity
ORDER BY c.start_time;

SELECT *
FROM NextWeekSchedule;







