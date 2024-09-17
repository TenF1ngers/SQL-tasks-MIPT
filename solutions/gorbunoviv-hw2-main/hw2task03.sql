SELECT b.facid, b.month, SUM(b.slots) as total_slots
FROM (
	SELECT *, EXTRACT(MONTH FROM starttime) as month
	FROM cd.bookings
	WHERE starttime > '2011-12-31 23:59:59' AND starttime < '2013-01-01 00:00:00'
) as b
GROUP BY b.facid, b.month
ORDER BY b.facid ASC, b.month ASC
