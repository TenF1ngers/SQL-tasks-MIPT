WITH RECURSIVE recs (memid, sname, fname) AS (
	SELECT memid, surname AS sname, firstname AS fname
	FROM cd.members AS m
	WHERE m.memid = 1
	
	UNION
	
	SELECT m.memid, m.surname AS sname, m.firstname AS fname
	FROM recs, cd.members AS m
	WHERE recs.memid = m.recommendedby
)
SELECT *
FROM (
	SELECT r.memid, r.fname AS firstname, r.sname AS surname
	FROM recs r
	OFFSET 1
) AS r
ORDER BY r.memid
