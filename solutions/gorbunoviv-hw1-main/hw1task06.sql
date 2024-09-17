SELECT dt, high_price, vol
FROM coins
WHERE to_date(dt, 'YYYY-MM-DD') >= '2018-01-01' AND
	   to_date(dt, 'YYYY-MM-DD') < '2019-01-01' AND
	   symbol = 'DOGE' AND (avg_price * 100) > 0.1
