-----------------------------------------------------------------------------------------------------------------------
/* First SQL QA Checks */
-----------------------------------------------------------------------------------------------------------------------

SELECT 'collisions' AS table_name, COUNT(*) AS row_count
FROM raw.collisions_last5_raw

UNION ALL

SELECT 'vehicles', COUNT(*)
FROM raw.vehicles_last5_raw

UNION ALL

SELECT 'casualties', COUNT(*)
FROM raw.casualties_last5_raw


/* Check Distinct Collisions */

SELECT COUNT(DISTINCT collision_index) AS distinct_collision_count
FROM raw.collisions_last5_raw;

/* Check duplicate vehicle keys */

SELECT
	collision_index,
	vehicle_reference,
	COUNT(*) AS duplicate_count
FROM raw.vehicles_last5_raw
GROUP BY collision_index, vehicle_reference
HAVING COUNT(*) > 1;

/* Check duplicate casualty keys */

SELECT 
	collision_index,
	casualty_reference,
	COUNT(*) AS duplicate_count
FROM raw.casualties_last5_raw
GROUP BY collision_index, casualty_reference
HAVING COUNT(*) > 1;

/* Text date conversion */

SELECT TOP 20
	[date],
	TRY_CONVERT(date, [date], 103) AS converted_date
FROM raw.collisions_last5_raw;