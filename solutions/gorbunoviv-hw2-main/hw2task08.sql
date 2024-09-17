WITH usages AS (
	SELECT i.memid, f.name
	FROM (
		SELECT b.memid, b.facid
		FROM cd.bookings AS b
		WHERE b.facid = 0 OR b.facid = 1
		GROUP BY b.facid, b.memid
	) AS i
	LEFT JOIN cd.facilities AS f
	ON i.facid = f.facid
)
SELECT CONCAT(m.firstname, ' ', m.surname) AS member, u.name AS facility
FROM usages AS u
LEFT JOIN cd.members AS m
ON u.memid = m.memid
ORDER BY member ASC, facility ASC
