# Raw Data

The raw datasets used in this project were downloaded from official UK public data sources.

## Department for Transport Road Safety Open Data

Files used:
- Road Safety Data - Collisions - last 5 years
- Road Safety Data - Vehicles - last 5 years
- Road Safety Data - Casualties - last 5 years

These files were used to analyse:
- collision trends
- casualties
- KSI casualties
- road-user groups
- speed-limit context
- lighting conditions
- urban/rural patterns
- timing patterns
- local-authority severe-harm burden

## Office for National Statistics Population Estimates

File used:
- Local-authority population estimates

This file was used to enrich the project with population-adjusted analysis, including KSI per 100,000 population.

## Why raw data is not committed

The raw datasets are not committed to this GitHub repository because they are large official public datasets.

To reproduce the project:
1. Download the DfT road safety last-five-years collisions, vehicles and casualties files.
2. Download the ONS local-authority population estimates.
3. Place the downloaded files in this folder.
4. Run the SQL scripts in the `sql/` folder in numerical order.