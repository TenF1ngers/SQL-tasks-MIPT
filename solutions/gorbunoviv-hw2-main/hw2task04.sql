WITH main AS (
	SELECT b.facid, b.month, SUM(b.slots) as slots
	FROM (
		SELECT *, EXTRACT(MONTH FROM starttime) as month
		FROM cd.bookings
		WHERE starttime > '2011-12-31 23:59:59' AND starttime < '2013-01-01 00:00:00'
	) as b
	GROUP BY b.facid, b.month
	ORDER BY b.facid ASC, b.month ASC
), total_fac AS (
	SELECT main.facid, CAST(NULL AS INTEGER) AS month, SUM(main.slots) as slots
	FROM main
	GROUP BY main.facid
)
SELECT *
FROM main
UNION
SELECT *
FROM total_fac
UNION
SELECT CAST(NULL AS INTEGER) AS facid, CAST(NULL AS INTEGER) as month, SUM(total_fac.slots) as slots
FROM total_fac
ORDER BY facid ASC, month ASC
