WITH maxes AS (
	SELECT full_nm AS full_name, MAX(high_price) AS price
	FROM coins
	GROUP BY full_nm
), dates AS (
	SELECT coins.full_nm AS full_name, MIN(to_date(coins.dt, 'YYYY-MM-DD')) AS dt
	FROM coins, maxes
	WHERE coins.full_nm = maxes.full_name AND coins.high_price = maxes.price
	GROUP BY coins.full_nm
)
SELECT UPPER(maxes.full_name) AS full_name, to_char(dates.dt, 'YYYY-MM-DD') AS dt, maxes.price
FROM dates
JOIN maxes
ON dates.full_name = maxes.full_name
ORDER BY maxes.price DESC, maxes.full_name ASC
