CREATE SCHEMA raw;
GO

CREATE SCHEMA rpt;
GO

ALTER SCHEMA raw TRANSFER dbo.collisions_last5_raw;
ALTER SCHEMA raw TRANSFER dbo.vehicles_last5_raw;
ALTER SCHEMA raw TRANSFER dbo.casualties_last5_raw;
