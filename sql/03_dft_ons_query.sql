-----------------------------------------------------------------------------------------------------------------------
/* Create population table using ONS local authority data */
-----------------------------------------------------------------------------------------------------------------------

ALTER SCHEMA raw TRANSFER dbo.ons_population_la_2024_raw;

-----------------------------------------------------------------------------------------------------------------------
/* Build a clean population view */


CREATE OR ALTER VIEW rpt.vw_population_la_2024 AS
SELECT
	la_code,
	la_name,
	TRY_CAST(population_total AS bigint) AS population_total
FROM raw.ons_population_la_2024_raw
WHERE TRY_CAST(population_total AS bigint) IS NOT NULL;
GO


-----------------------------------------------------------------------------------------------------------------------
/* Join DfT with ONS data for rate analysis */

CREATE OR ALTER VIEW rpt.vw_la_ksi_summary AS
SELECT
	c.local_authority_ons_district AS la_code,
	COUNT(*) AS total_casualties,
	SUM(CASE WHEN c.ksi_flag = 1 THEN 1 ELSE 0 END) AS ksi_casualties
FROM rpt.vw_casualty_analysis c
WHERE c.local_authority_ons_district IS NOT NULL
GROUP BY c.local_authority_ons_district;
GO


CREATE OR ALTER VIEW rpt.vw_la_ksi_rates AS
SELECT
	s.la_code,
	p.la_name,
	s.total_casualties,
	s.ksi_casualties,
	p.population_total,
	CAST(100000.0 * s.total_casualties / NULLIF(p.population_total, 0) AS decimal(12,2)) AS casualties_per_100k,
	CAST(100000.0 * s.ksi_casualties / NULLIF(p.population_total, 0) AS decimal(12,2)) AS ksi_per_100k
FROM rpt.vw_la_ksi_summary s
LEFT JOIN rpt.vw_population_la_2024 p
	ON s.la_code = p.la_code;
GO


-----------------------------------------------------------------------------------------------------------------------




