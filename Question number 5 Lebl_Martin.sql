CREATE OR REPLACE VIEW v_martin_lebl_GDP_diff AS
WITH gdp_diff AS (
SELECT
	country,
	`year`,
	GDP 
FROM t_martin_lebl_project_sql_secondary_final pss
WHERE 
	country = 'Czech Republic')
SELECT
	gd.country,
	gd.`year`,
	gd.GDP,
	gd2.`year` AS previous_year,
	gd2.GDP AS previous_year_GDP,
	round((gd.GDP-gd2.GDP),2) AS GDP_diff,
	round((gd.GDP-gd2.GDP)/gd2.GDP*100,2) AS GDP_percentage_diff
FROM gdp_diff AS gd
JOIN gdp_diff AS gd2
	ON gd.country = gd2.country AND 
	gd.`year` = gd2.`year` +1;

SELECT -- porovnání HDP, meziročního nárůstu mezd a cen
	gd.`year`,
	gd.country,
	gd.GDP_percentage_diff,
	aw.avg_wages_percentage_diff,
	agp.avg_price_percentage_diff 
FROM v_martin_lebl_gdp_diff gd
JOIN v_martin_lebl_avg_wages_diff aw
	ON gd.`year` = aw.`year`
JOIN v_martin_lebl_avg_grocery_price_diff agp
	ON gd.`year` = agp.`year`; 
	
