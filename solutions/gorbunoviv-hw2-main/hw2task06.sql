WITH recom AS (
	SELECT DISTINCT recommendedby as rec
	FROM cd.members as m
	WHERE recommendedby IS NOT NULL
)
SELECT m.firstname, m.surname
FROM cd.members AS m, recom AS r
WHERE m.memid = r.rec
ORDER BY m.surname ASC, m.firstname ASC
