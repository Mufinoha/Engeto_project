CREATE OR REPLACE VIEW v_martin_lebl_avg_wages AS
SELECT
	DISTINCT pf.name,
	pf.`year`,
	round(avg(pf.value)) AS avg_wages 
FROM t_martin_lebl_project_sql_primary_final_1 pf
GROUP BY
	pf.name,
	pf.`year`
ORDER BY 
	pf.`year`ASC,
	pf.name ASC;

CREATE OR REPLACE VIEW v_martin_lebl_wages_percentage_diff AS
SELECT
	DISTINCT aw.name AS name_of_industry,
	aw.`year`,
	aw.avg_wages,
	aw2.`year` AS previous_year,
	aw2.avg_wages AS previous_year_avg_wages,
	round((aw.avg_wages-aw2.avg_wages)/aw2.avg_wages*100,2) AS wages_percentage_diff 
FROM v_martin_lebl_avg_wages aw
JOIN v_martin_lebl_avg_wages aw2
	ON aw.name = aw2.name AND 
	aw.`year` = aw2.`year` +1
GROUP BY
	aw.name,
	aw.avg_wages,
	aw.`year`,
	aw2.`year`,
	aw2.avg_wages;

CREATE OR REPLACE VIEW v_martin_lebl_avg_wages_diff AS	
SELECT 
	`year`,
	round(avg(wages_percentage_diff),2) AS avg_wages_percentage_diff 
FROM v_martin_lebl_wages_percentage_diff vmlwpd
GROUP BY
	`year`;

CREATE OR REPLACE VIEW v_martin_lebl_avg_grocery_price_diff AS 
SELECT 
	`year`,
	round(avg(price_percentage_diff),2) AS avg_price_percentage_diff 
FROM v_martin_lebl_grocery_prices_percentage_diff gpp
GROUP BY
	`year`;

SELECT -- porovnání rozdílů mezi cenami a mzdami za jednotlivé roky
	agpd.`year`,
	agpd.avg_price_percentage_diff,
	awd.`year`,
	awd.avg_wages_percentage_diff,
	(agpd.avg_price_percentage_diff-awd.avg_wages_percentage_diff) AS percentage_comparison
FROM v_martin_lebl_avg_grocery_price_diff agpd
JOIN v_martin_lebl_avg_wages_diff awd
	ON agpd.`year` = awd.`year`
ORDER BY
	percentage_comparison DESC;


