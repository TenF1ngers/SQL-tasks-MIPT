SELECT CONCAT(rec.firstname, ' ', rec.surname) AS member,
		CASE
			WHEN rec.recommendedby IS NOT NULL THEN (
				SELECT CONCAT(tmp.firstname, ' ', tmp.surname)
				FROM cd.members AS tmp
				WHERE tmp.memid = rec.recommendedby
			)
			ELSE NULL
		END AS recommender
FROM cd.members AS rec
ORDER BY member ASC
