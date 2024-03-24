CREATE OR REPLACE TABLE t_martin_lebl_project_sql_secondary_final AS
SELECT
	country,
	`year`,
	GDP,
	gini,
	taxes,
	population
FROM economies e
WHERE 
	`year` BETWEEN 2006 AND 2018
	AND gini IS NOT NULL
ORDER BY 
	`year` ASC,
	country ASC;
	