## Part I Requirements

### Building the Data Warehouse/Pipeline & Performing ETL

Objective

Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making through the process of Extracting, Transforming and Loading the data.

- **Data Sources**: ChatGPT generated data

<br>

**STEPS**

- Upload data to SSMS from data sources
- Create the data architecture required (the database) to house the data (in our case, the medallion architecture)
- Transform and clean the data
- Create/Define the data model we will use for the final business objects (gold layer views) by establishing fact & dimension tables
- Load the data into business objects that will be used to perform Part II EDA (Exploratory Data Analysis)

<br>

🧰**SKILLS DEMONSTRATED**🧰

- Database Engineering
- Data Validation (true validation)
- Data Modeling
- Data Normalization
- Data Cleaning

* * *

<br>

## 🏗️ Data Architecture (structure for building the data warehouse)

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

* * *

<br>

## 📂 Part I Repository Structure

```
Bike-Retail-End-to-End-Analytics-Project/
01-etl-data-pipeline/                   # ETL data pipeline and data warehouse build process
│
├── datasets/                           # Raw datasets used for the project
│   ├── raw_customers.csv               # Raw customer data
│   ├── raw_products.csv                # Raw product data
│   └── raw_sales.csv                   # Raw sales transaction data
│
├── documents/                          # Supporting project documentation and observations
│   └── observations_bike_retail.md     # Notes, observations, and project findings
│
├── scripts/                            # SQL scripts for ETL and transformations
│   │
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   │   ├── ddl_bronze.sql              # Creates bronze layer tables
│   │   └── proc_load_bronze.sql        # Loads raw CSV data into bronze tables
│   │
│   ├── silver/                         # Scripts for cleaning and transforming data
│   │   ├── ddl_silver.sql              # Creates silver layer tables
│   │   └── proc_load_silver.sql        # Cleans, standardizes, and loads data into silver tables
│   │
│   ├── gold/                           # Scripts for creating analytical models
│   │   ├── ddl_gold.sql                # Creates the gold layer views/business-ready views structure
│   │   ├── gold.dim_customers          # Creates the gold customer dimension view
│   │   ├── gold.dim_products           # Creates the gold product dimension view
│   │   └── gold.fact_sales             # Creates the gold sales fact view
│   │
│   └── init_database.sql               # Initializes the database and required schemas
│
├── tests/                              # Test scripts and quality files
│   ├── quality_checks_gold.sql         # Validation checks for gold layer analytical objects
│   └── quality_checks_silver.sql       # Validation checks for silver layer cleaned/transformed data
│
└── README.md                           # Project overview, requirements, architecture, and instructions
```

<br>
