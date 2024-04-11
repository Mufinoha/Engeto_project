CREATE OR REPLACE VIEW v_martin_lebl_question_2 AS -- pomocný pohled
SELECT
	category_code,
	food_category,
	`year`,
	price_in_year,
	value
FROM t_martin_lebl_project_sql_primary_final_1 AS pf; 

SELECT -- Určení min. a max. měření + categorie
	vmlq.category_code,
	vmlq.food_category,
	min(vmlq.`year`) AS first_measurement,
	max(vmlq.`year`) AS last_measurement
FROM v_martin_lebl_question_2 vmlq
WHERE 
	lower(vmlq.food_category) LIKE ('%chléb%') OR
	lower(vmlq.food_category) LIKE ('%mléko%')
GROUP BY
	vmlq.category_code,
	vmlq.food_category;

CREATE OR REPLACE VIEW v_martin_lebl_finall_question_2 AS -- finální výpočet
SELECT
	vmlq.`year`,
	vmlq.food_category,
	vmlq.price_in_year AS avg_prices,
	round(avg(value)) AS avg_wages,
	round(sum(vmlq.value)/sum(vmlq.price_in_year)) AS pcs 
FROM v_martin_lebl_question_2 vmlq 
WHERE category_code IN (111301,114201) AND `year` IN (2006,2018)
GROUP BY 
	vmlq.`year`,
	vmlq.food_category,
	vmlq.price_in_year
ORDER BY
	vmlq.food_category ASC,
	vmlq.`year` ASC;