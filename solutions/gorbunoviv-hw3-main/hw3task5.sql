WITH gu AS (
	SELECT g.facid, g.slots * f.guestcost AS cost
	FROM (
		SELECT b.facid, SUM(b.slots) AS slots
		FROM cd.bookings AS b
		WHERE b.memid = 0
		GROUP BY b.facid
	) AS g, cd.facilities AS f
	WHERE g.facid = f.facid
), me AS (
	SELECT m.facid, m.slots * f.membercost AS cost
	FROM (
		SELECT b.facid, SUM(b.slots) AS slots
		FROM cd.bookings AS b
		WHERE b.memid != 0
		GROUP BY b.facid
	) AS m, cd.facilities AS f
	WHERE m.facid = f.facid
)
SELECT f.name, RANK() OVER (ORDER BY gu.cost + me.cost DESC) AS rank
FROM gu, me, cd.facilities AS f
WHERE gu.facid = me.facid AND gu.facid = f.facid
ORDER BY rank, f.name
LIMIT 3


	
	
	
	
	
