SELECT ROW_NUMBER() OVER (ORDER BY t.vol DESC) AS rank, t.dt, t.vol
FROM (
	SELECT dt, SUM(vol) AS vol
	FROM coins
	GROUP BY dt
	ORDER BY SUM(vol) DESC
	LIMIT 10
) as t
