WITH books AS (
	SELECT memid, MIN(starttime) as starttime
	FROM cd.bookings as b
	WHERE b.starttime > '2012-08-31 23:59:59'
	GROUP BY memid
	ORDER BY memid
)
SELECT m.surname, m.firstname, m.memid, b.starttime
FROM cd.members AS m
LEFT JOIN books as b
ON m.memid = b.memid
