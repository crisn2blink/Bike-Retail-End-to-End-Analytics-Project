# Bike Retail End-to-End Analytics Project

Welcome to the **Bike Retail** repository! This is a three-part project that demonstrates a comprehensive data warehousing and analytics solutions, from building a data warehouse to generating actionable insights through the creation of a business-intelligence dashboard. Designed as a portfolio project that highlights industry best practices in data engineering and analytics.

Data is fictitious and was generated using ChatGPT.

<br>

THREE PARTS TO THE PROJECT

1. Part I: ETL (Extract, Transform & Load) Data Pipeline Creation
2. Part II: EDA (Exploratory Data Analysis)
3. Part III: Power BI Dashboard

<br>

## 🧭 How to Navigate this Repository

After reading the entirety of this very short README page to understand how the project is segmented, please feel free to proceed to Part I of this three part project via the folder titled:

- 01-etl-data-pipeline

<br>

Make sure to once again read the full README found within this folder and navigate through the folders inquisitively.

<br>

Once Part I has been covered, proceed in the same manner (making sure to read the README document in each Part folder) for the following two folders:

- 02-eda
- 03-dashboard

<br>
Ultimately, this will provide a clear picture of the overall project and will also highlight my abilities as a business analyst and data engineer (which is the entire point of this portfolio project).

* * *

<br>

## 📖 Full Project Overview

This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **EDA**: Performing Exploratory Data Analysis for the sake of gathering general business insights
5. **Analytics & Dashboard Creation**: Creating Power BI interactive dashboard for actionable insights.

<br>

🎯 This repository is an excellent resource for professionals and students looking to showcase expertise in:

- SQL Development
- Data Architect
- Data Engineering
- ETL Pipeline Developer
- Data Modeling
- Data Analytics
- Dashboard Design

* * *

<br>

## Project Requirements

### Part I: Building the Data Warehouse (Data Engineering) & Pipeline

Tools used: SSMS

Objective

Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications

- **Data Sources**: Import data from one source system (ChatGPT) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

<br>

### Part II: EDA (Exploratory Data Analysis)

Tools used: SSMS

#### Objective

Perform initial EDA using the business objects (gold layer views) created in Part I to:

- Begin to understand general business KPIs.
- Understand the data and get a general snapshot of company performance.
- Begin aggregating information to build the business dashboard with.

<br>

### Part III: BI: Analytics & Reporting (Data Analytics)

Tools used: Power BI

#### Objective

Develop Power BI dashboard based on Part II EDA results to deliver detailed business insights into:

- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.

* * *

<br>

## 📂 General Repository Structure

```
├── 01-etl-data-pipeline/
│   ├── datasets/
│   ├── scripts/
│   ├── tests/
│   ├── README.md
│
├── 02-eda/
│   ├── documents/
│   ├── queries/
│   ├── README.md
│
├── 03-dashboard/
│   ├── dashboard/
│   ├── documents/
│   ├── README.md
│
└── docs/
    ├── data_catalog.md                   # Catalog of datasets, including field descriptions and metadata
    ├── data_flow_diagram.drawio          # Draw.io file that shows the flow of data within the pipeline
    ├── integration_model_diagram.drawio  # Draw.io file shows the project's star schema model
    ├── naming_conventions.md             # Consistent naming guidelines for tables, columns, and files
    ├── project_diagram.drawio            # Draw.io file shows the project's architecture
    ├── sales_data_mart.drawio            # Draw.io file for data models (star schema)
    
```

* * *

<br>

## License

This project is licensed under the \[MIT License\] (LICENSE). You are free to use, modify and share this project with proper attribution.

* * *

<br>

## About Me

Hi! I'm **Cristian Cervantes**. I'm a developing business analyst and yoga practitioner on a mission to share knowledge while simultaneously develop my skills. My core
compentencies lie in taking an analysis project from conceptualization to the final dashboard presentation; dealing with all aspects from database engineering all the way to dashboard creation.
