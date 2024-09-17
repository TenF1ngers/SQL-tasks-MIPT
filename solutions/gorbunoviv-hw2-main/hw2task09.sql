SELECT *
FROM (
	SELECT CONCAT(m.firstname, ' ', m.surname) AS member, f.name AS facility,
		CASE
			WHEN m.memid = 0 THEN b.slots * f.guestcost
			ELSE b.slots * f.membercost
		END AS cost
	FROM cd.bookings AS b, cd.members AS m, cd.facilities AS f
	WHERE b.starttime > '2012-09-13 23:59:59' AND b.starttime < '2012-09-15 00:00:00'
		   AND b.memid = m.memid AND b.facid = f.facid
) AS tmp
WHERE cost > 30
ORDER BY cost DESC, member ASC, facility ASC
