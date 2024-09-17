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
), inc AS (
	SELECT f.name, NTILE(3) OVER (ORDER BY gu.cost + me.cost DESC) AS revenue
	FROM gu, me, cd.facilities AS f
	WHERE gu.facid = me.facid AND gu.facid = f.facid
	ORDER BY revenue, f.name
)
SELECT inc.name,
	CASE
		WHEN inc.revenue = 1 THEN 'high'
		WHEN inc.revenue = 2 THEN 'average'
		ELSE 'low'
	END AS revenue
FROM inc

	
	
	
	
	
