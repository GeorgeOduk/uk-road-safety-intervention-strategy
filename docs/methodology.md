# Methodology

## 1. Project Framing

The project was framed as a consulting-style road safety strategy problem:

**Where should limited road-safety investment be targeted to reduce KSI casualties most effectively?**

KSI refers to casualties who were killed or seriously injured.

## 2. Data Acquisition

The project uses:
- Department for Transport road safety open data
- Office for National Statistics population estimates

The main DfT tables used were:
- collisions
- vehicles
- casualties

The ONS dataset was used to calculate population-adjusted local-authority metrics.

## 3. SQL Server Preparation

The raw datasets were imported into SQL Server and structured using a raw schema and reporting views.

The SQL scripts are organised as:

1. `01_schema_query.sql`
2. `02_reporting_views_query.sql`
3. `03_dft_ons_query.sql`
4. `04_qa_checks_query.sql`

## 4. Power BI Dashboard

The Power BI dashboard was designed as a four-page consulting-style report:

1. Executive Summary
2. Who is Most at Risk?
3. Where and When is Risk Concentrated?
4. Intervention Targeting

The dashboard focuses on:
- KSI volume
- KSI percentage
- KSI per 100,000 population
- road-user group
- casualty demographics
- deprivation-linked patterns
- local-authority concentration
- speed, lighting and time patterns

## 5. Excel QA Workbook

The Excel workbook was used for quality assurance and supporting checks.

## 6. Executive Deck

The PowerPoint deck translates the dashboard into a recommendation-led executive summary.

It includes:
- answer-first recommendation
- evidence of concentrated harm
- three intervention priorities
- 90-day implementation and KPI framework

## 7. Recommendation Logic

Priority was assigned by considering:
- severe-harm volume
- severity concentration
- population-adjusted burden
- deprivation-linked patterns
- intervention relevance
- practical actionability

The final recommendation is to prioritise targeted pilots rather than broad, undifferentiated road safety activity.