SELECT * FROM t_martin_lebl_project_sql_primary_final_1 pf;

CREATE OR REPLACE INDEX i_primary_price ON t_martin_lebl_project_sql_primary_final_1(price_in_year);

CREATE OR REPLACE VIEW v_martin_lebl_grocery_prices AS
SELECT 
	DISTINCT food_category,
	category_code,
	`year`,
	price_in_year 
FROM t_martin_lebl_project_sql_primary_final_1 tmlpspf
ORDER BY food_category ASC, `year`;


CREATE OR REPLACE VIEW v_martin_lebl_grocery_prices_percentage_diff AS
SELECT
	vmlgp.`year`,
	vmlgp.food_category,
	vmlgp.price_in_year,
	vmlgp2.`year`AS previous_year,
	vmlgp2.price_in_year AS previous_price_in_year,
	round((vmlgp.price_in_year-vmlgp2.price_in_year)/vmlgp2.price_in_year*100,2) AS price_percentage_diff 
FROM v_martin_lebl_grocery_prices vmlgp 
JOIN v_martin_lebl_grocery_prices vmlgp2 
	ON vmlgp.category_code = vmlgp2.category_code AND 
	vmlgp.`year` = vmlgp2.`year` +1
GROUP BY 
	vmlgp.`year`,
	vmlgp.food_category,
	vmlgp.price_in_year,
	vmlgp2.`year`,
	vmlgp2.price_in_year
ORDER BY
	vmlgp.food_category ASC,
	vmlgp.`year`;
	
CREATE OR REPLACE VIEW v_martin_lebl_price_percentage_diff AS
SELECT 
	 vgp.food_category,
	 round(avg(vgp.price_percentage_diff),2) AS price_percentage_diff  
FROM v_martin_lebl_grocery_prices_percentage_diff AS vgp
GROUP BY
	vgp.food_category
ORDER BY 
	price_percentage_diff;








