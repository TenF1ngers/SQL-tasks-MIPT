SELECT hw.id,
		(weight / 2.2046) / (height * 0.0254 * height * 0.0254) AS bmi,
		CASE
			WHEN (weight / 2.2046) / (height * 0.0254 * height * 0.0254)<18.5 THEN 'underweight'
			WHEN (weight / 2.2046) / (height * 0.0254 * height * 0.0254)>=18.5 AND (weight / 2.2046) / (height * 0.0254 * height * 0.0254)<25 THEN 'normal'
			WHEN (weight / 2.2046) / (height * 0.0254 * height * 0.0254)>=25 AND (weight / 2.2046) / (height * 0.0254 * height * 0.0254)<30 THEN 'overweight'
			WHEN (weight / 2.2046) / (height * 0.0254 * height * 0.0254)>=30 AND (weight / 2.2046) / (height * 0.0254 * height * 0.0254)<35 THEN 'obese'
			ELSE 'extremely obese'
		END
		AS type
FROM hw
ORDER BY bmi DESC, id DESC
