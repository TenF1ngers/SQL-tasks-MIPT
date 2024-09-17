SELECT full_nm as full_name, AVG(avg_price) as avg_price,
		MAX(high_price) as max_price, MIN(low_price) as min_price
FROM coins
GROUP BY full_nm
