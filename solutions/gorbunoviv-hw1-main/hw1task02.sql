SELECT w / (h * h) as bmi
FROM (SELECT height * 0.0254 as h, weight / 2.2046 as w FROM hw) as ta
