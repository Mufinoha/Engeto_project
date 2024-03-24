-- Discord Lebl M. (Mufinoha)
SELECT *
FROM t_martin_lebl_project_sql_primary_final_1 pf 

WITH avg_wages AS (
	SELECT 
		`year`,
		name,
		round(avg(value)) AS avg_wages
	FROM t_martin_lebl_project_sql_primary_final_1 AS pf 
	GROUP BY `year`,name
	)
SELECT
	DISTINCT aw.name,
	aw.`year`,
	aw.avg_wages,
	aw1.`year`,
	aw1.avg_wages AS previous_year_avg_wages,
	CASE 
		WHEN (aw.avg_wages-aw1.avg_wages) > 1 THEN lower('ASCENDING')
		ELSE 'DESCENDING'
	END AS wage_comparison
FROM avg_wages AS aw
JOIN avg_wages AS aw1
	ON aw.name = aw1.name AND 
	aw.`year` = aw1.`year`+1
ORDER BY
	aw.name ASC,
	aw.`year` DESC;