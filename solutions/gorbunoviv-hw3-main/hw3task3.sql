WITH h AS (
	SELECT memid, ROUND(SUM(slots) * 0.5, -1) AS hours
	FROM cd.bookings AS b
	GROUP BY memid
)
SELECT m.firstname, m.surname, h.hours, RANK() OVER (
	ORDER BY h.hours DESC
) AS rank
FROM cd.members AS m, h
WHERE m.memid = h.memid
ORDER BY rank, m.surname, m.firstname
