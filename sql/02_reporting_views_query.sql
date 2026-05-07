/*
First reporting view: collision-level view
*/

CREATE OR ALTER VIEW rpt.vw_collision_analysis AS
SELECT
	c.collision_index,
	TRY_CONVERT(date, c.[date], 103) AS collision_date,
	YEAR(TRY_CONVERT(date, c.[date], 103)) AS collision_year,
	MONTH(TRY_CONVERT(date, c.[date], 103)) AS collision_month_num,
	DATENAME(MONTH, TRY_CONVERT(date, c.[date], 103)) AS collision_month_name,
	c.[time] AS collision_time,
	c.local_authority_district,
	c.local_authority_ons_district,
	c.collision_severity,
	CASE
		WHEN c.collision_severity = 1 THEN 'Fatal'
		WHEN c.collision_severity = 2 THEN 'Serious'
		WHEN c.collision_severity = 3 Then 'Slight'
		ELSE 'Unknown'
	END AS collision_severity_label,
	c.number_of_vehicles,
	c.number_of_casualties,
	c.day_of_week,
	CASE
		WHEN c.day_of_week = 1 THEN 'Sunday'
		WHEN c.day_of_week = 2 THEN 'Monday'
		WHEN c.day_of_week = 3 THEN 'Tuesday'
		WHEN c.day_of_week = 4 THEN 'Wednesday'
		WHEN c.day_of_week = 5 THEN 'Thursday'
 		WHEN c.day_of_week = 6 THEN 'Friday'
		WHEN c.day_of_week = 7 THEN 'Saturday'
		ELSE 'Unknown'
	END AS day_of_week_label,
	c.road_type,
	c.speed_limit,
	c.junction_detail,
	c.junction_control,
	c.light_conditions,
	c.weather_conditions,
	c.road_surface_conditions,
	c.urban_or_rural_area,
	CASE 
		WHEN c.urban_or_rural_area = 1 THEN 'Urban'
		WHEN c.urban_or_rural_area = 2 THEN 'Rural'
		ELSE 'Unknown'
	END AS urban_rural_label,
	c.latitude,
	c.longitude
FROM raw.collisions_last5_raw c
WHERE TRY_CONVERT(date, c.[date], 103) IS NOT NULL;
GO

-----------------------------------------------------------------------------------------------------------------------
/* 
Main Reporting View: Casualty-level analysis view */
---------------------------------------------------------

CREATE OR ALTER VIEW rpt.vw_casualty_analysis AS
SELECT
	cas.collision_index,
	cas.casualty_reference,
	TRY_CONVERT(date, col.[date], 103) AS collision_date,
	YEAR(TRY_CONVERT(date, col.[date], 103)) AS collision_year,
	MONTH(TRY_CONVERT(date, col.[date], 103)) AS collision_month_num,
	DATENAME(MONTH, TRY_CONVERT(date, col.[date], 103)) AS collision_month_name,
	col.[time] AS collision_time,

	col.local_authority_district,
	col.local_authority_ons_district,

	col.collision_severity,
	CASE
		WHEN col.collision_severity = 1 THEN 'Fatal'
		WHEN col.collision_severity = 2 THEN 'Serious'
		WHEN col.collision_severity = 3 THEN 'Slight'
		ELSE 'Unknown'
	END AS collision_severity_label,

	cas.casualty_severity,
	CASE
		WHEN cas.casualty_severity = 1 THEN 'Fatal'
		WHEN cas.casualty_severity = 2 THEN 'Serious'
		WHEN cas.casualty_severity = 3 THEN 'Slight'
		ELSE 'Unknown'
	END AS casualty_severity_label,

	CASE
		WHEN cas.casualty_severity IN (1,2) THEN 1
		ELSE 0
	END AS ksi_flag,

	cas.casualty_class,
	CASE
		WHEN cas.casualty_class = 1 THEN 'Driver/Rider'
		WHEN cas.casualty_class = 2 THEN 'Passenger'
		WHEN cas.casualty_class = 3 THEN 'Pedestrian'
		ELSE 'Unknown'
	END AS casualty_class_label,

	cas.sex_of_casualty,
	CASE
		WHEN cas.sex_of_casualty = 1 THEN 'Male'
		WHEN cas.sex_of_casualty = 2 THEN 'Female'
		ELSE 'Unknown'
	END AS sex_of_casualty_label,

	cas.age_of_casualty,
	cas.age_band_of_casualty,

	CASE
		WHEN cas.age_of_casualty BETWEEN 0 AND 15 THEN '0-15'
		WHEN cas.age_of_casualty BETWEEN 16 AND 24 THEN '16-24'
		WHEN cas.age_of_casualty BETWEEN 25 AND 34 THEN '25-34'
		WHEN cas.age_of_casualty BETWEEN 35 AND 44 THEN '35-44'
		WHEN cas.age_of_casualty BETWEEN 45 AND 54 THEN '45-54'
		WHEN cas.age_of_casualty BETWEEN 55 AND 64 THEN '55-64'
		WHEN cas.age_of_casualty >= 65 THEN '65+'
		ELSE 'Unknown'
	END AS casualty_age_band_custom,

	cas.casualty_type,

	CASE 
		WHEN cas.casualty_type IN (0,1) THEN 'Pedestrian'
		WHEN cas.casualty_type IN (2,3,4,5,23) THEN 'Cyclist'
		WHEN cas.casualty_type IN (8,9, 10,11) THEN 'Motorcyclist'
		WHEN cas.casualty_type IN (19,20,21) THEN 'Van/Light Goods Occupant'
		WHEN cas.casualty_type IN (22) THEN 'Bus/Coach Occupant'
		ELSE 'Car/Other Vehicle Occupant'
	END AS road_user_group,

	cas.casualty_imd_decile,
	cas.lsoa_of_casualty,

	col.number_of_vehicles,
	col.number_of_casualties,
	col.day_of_week,
	CASE
		WHEN col.day_of_week = 1 THEN 'Sunday'
		WHEN col.day_of_week = 2 THEN 'Monday'
		WHEN col.day_of_week = 3 THEN 'Tuesday'
		WHEN col.day_of_week = 4 THEN 'Wednesday'
		WHEN col.day_of_week = 5 THEN 'Thursday'
		WHEN col.day_of_week = 6 THEN 'Friday'
		WHEN col.day_of_week = 7 THEN 'Saturday'
		ELSE 'Unknown'
	END AS day_of_week_label,

	col.road_type,
	col.speed_limit,
	col.junction_detail,
	col.junction_control,
	col.light_conditions,
	col.weather_conditions,
	col.urban_or_rural_area,
	CASE
		WHEN col.urban_or_rural_area = 1 THEN 'Urban'
		WHEN col.urban_or_rural_area = 2 THEN 'Rural'
		ELSE 'Unknown'
	END AS urban_rural_label,
	col.latitude,
	col.longitude

FROM raw.casualties_last5_raw cas
INNER JOIN raw.collisions_last5_raw col
	ON cas.collision_index = col.collision_index
WHERE TRY_CONVERT(date, col.[date], 103) IS NOT NULL;
GO

-----------------------------------------------------------------------------------------------------------------------
/* Vehicle enrichment view */
-----------------------------------------------------------------------------------------------------------------------

CREATE OR ALTER VIEW rpt.vw_vehicle_analysis AS
SELECT
	v.collision_index,
	v.vehicle_reference,
	v.vehicle_type,
	v.sex_of_driver,
	v.age_of_driver,
	v.driver_imd_decile,
	v.journey_purpose_of_driver,
	v.engine_capacity_cc,
	v.propulsion_code
FROM raw.vehicles_last5_raw v;
GO

-----------------------------------------------------------------------------------------------------------------------
/* Validating reporting views */
-----------------------------------------------------------------------------------------------------------------------

SELECT COUNT(*) AS casualty_rows
FROM rpt.vw_casualty_analysis;

SELECT TOP 20 *
FROM rpt.vw_casualty_analysis;

SELECT collision_year, COUNT(*) AS casualty_count
FROM rpt.vw_casualty_analysis
GROUP BY collision_year
ORDER BY collision_year;

SELECT casualty_severity_label, COUNT(*) AS cnt
FROM rpt.vw_casualty_analysis
GROUP BY casualty_severity_label;

SELECT road_user_group, COUNT(*) AS cnt
FROM rpt.vw_casualty_analysis
GROUP BY road_user_group
ORDER BY cnt DESC;

-----------------------------------------------------------------------------------------------------------------------
/* Null Checks */

SELECT COUNT(*) AS null_count
FROM rpt.vw_casualty_analysis
WHERE speed_limit IS NULL;