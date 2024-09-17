WITH RECURSIVE fibonacci(nth, value, fib_n_m1) AS (
    SELECT 0 AS nth, 1::numeric AS value, 0::numeric AS fib_n_m1
    UNION
	SELECT nth + 1, value + fib_n_m1, value
	FROM fibonacci
	WHERE nth < 99
)
SELECT nth, value FROM fibonacci;
