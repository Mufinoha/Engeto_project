-- Discord Lebl M. (Mufinoha)
CREATE OR REPLACE TABLE t_martin_lebl_project_sql_primary_final_1 AS 
SELECT -- nástřel primární tabulky
	cp.payroll_year AS 'year',
	cpib.name,
	cp.value,
	cp2.category_code,
	cpc.name AS food_category,
	round(avg(cp2.value),2) AS price_in_year
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib
	ON cp.industry_branch_code = cpib.code
LEFT JOIN czechia_price cp2 
	ON year(cp2.date_from) = cp.payroll_year
LEFT JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code
WHERE 
	cp.value_type_code = 5958 
	AND cp.industry_branch_code IS NOT NULL
	AND cp.value IS NOT NULL AND 
	calculation_code = 200
	AND cp2.region_code IS NULL	AND
	cp.payroll_year BETWEEN 2006 AND 2018
GROUP BY 
	cp.payroll_year,
	cpib.name,
	cp.value,
	cp2.category_code,
	cpc.name;

CREATE OR REPLACE INDEX i_primary_final ON czechia_price(value);