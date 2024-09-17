SELECT names.firstname AS memfname, names.surname AS memsname,
		recs.firstname AS recfname, recs.surname AS recsname
FROM cd.members AS names
LEFT JOIN cd.members AS recs
ON names.recommendedby = recs.memid
ORDER BY names.surname ASC, names.firstname ASC
