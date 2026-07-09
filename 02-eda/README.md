# README EDA Bike Project

## Part II: EDA

A comprehensive collection of SQL scripts for data exploration, analytics, and reporting. These scripts cover various analyses such as database exploration, measures and metrics, time-based trends, cumulative analytics, segmentation, and more. This repository contains SQL queries designed to help data analysts and BI professionals quickly explore, segment, and analyze data within a relational database. Each script focuses on a specific analytical theme and demonstrates best practices for SQL queries.

* * *

<br>

## Part II Requirements

### Performing EDA (Exploratory Data Analysis)

Objective

Perform EDA using the output of Part I (the gold layer business views) to gain general business insights and to begin shaping the blueprint for the dashboard created in Part III

- **Data Sources**: gold layer business views

<br>

**STEPS**

- Run the EDA queries and record the results
- Summarize the results in a one-page document (summary page)

<br>

🧰**SKILLS DEMONSTRATED**🧰

- Data Analysis
- EDA
- Critical Thinking
- Understanding of Business Operations

* * *

<br>

## 🎯 EDA Analysis Breakdown

1. **Dimension Exploration:**
    - Identify the unique values (or categories) in each dimension
    - Recognizing how data might be grouped or segmented, which is useful for later analysis
    - Understanding the granularity of our dimensions as well as the hierarchical layers

  

2. **Date Exploration**: Find the dates for the range of orders
    - Identify the earliest and latest dates (boundaries)
    - Understand the time-span

  

Syntax:

MIN/MAX \[date dimensions\]

  

3. **Measure Exploration**
    - Calculate and find out the key metrics of our business (Big Numbers)
    - Highest level of aggregation/lowest level of details

  

Examples:

- SUM(Sales)
- AVG(price)
- SUM(quantity)
- COUNT(DISTINCT customer\_key)

  

4. **Magnitude Analysis**
    - Here we will start putting things together and really begin our analysis (this is basic).
    - Magnitude analysis is comparing the measure values **by categories**.
    - Helps us to understand the importance of different categories.

  

Scenarios:

- Total sales by country
- Total quantity by category
- Average price by products
- Total orders by customers

  

5. **Ranking Analysis**
    - Order the values and dimensions by measures
    - Top performers|Bottom performers

  

Examples:

- RANK \[dimension\] by \[measure\]
- RANK countries by total\_sales
- TOP 5 products by quantity
- BOTTOM 3 customers by total\_sales

  

6. **Change Over Time**  
    - Technique to analyze how a measure evolves over time
    - Helps to track trends and identify seasonality

  

Scenarios:

- Total sales by year
- Average cost by month

  

7. **Cumulative Analysis**: Running total & Moving Average
    - Used to aggregate the data progressively across time
    - Helps to understand whether our business is growing or declining
    - Very similar to change over time but cumulative

  

Case Use:

- Aggregate \[cumulative measure\] By \[date dimension\]

  

8. **Performance Analysis (YoY Analysis)**
    - Process of comparing the current value with a target value. 

  

Case Use:

- Current\[measure\] - Target\[measure\]

  

Scenarios:

- Current sales - Average sales
- Current year sales - previous year sales
- Current sales - lowest sales
- Highest sales - Current sales

  

9. **Part-to-Whole Analysis**
    - Proportional Analysis: Analyze how an individual part is performing compared to the overall, allowing us to understand which category has the greatest impact on the business.

  

Case Use:

- (\[measure\]/Total \[measure\]) \* 100 BY \[dimension\]

  

Examples:

- (Sales/Total Sales) \* 100 By Category
- (Quantity/Total Quantity) \* 100 By Country

  

10. **Data Segmentation Analysis**
    - Group the data based on a specific range
    - Helps to understand the correlation between two measures

  

Case Use:

- \[Measure\] by \[Measure\]

  

Scenarios:

- Total products By Sales Range
- Total customers By Age

  

THE RESULTS OF THE EDA ARE FOUND IN THE “SUMMARY PAGE” DOCUMENT IN THIS REPOSITORY

* * *

<br>

## 📂 Part II Repository Structure

```
AdventureWorks-Business-Intelligence-Dashboard/
02-eda/                                  # Exploratory Data Analysis using the gold layer business views
│
├── documents/                           # Supporting EDA documentation, notes, sketches, and roadmap materials
│   ├── eda_summary_notes.pdf            # Summary notes and key findings from the exploratory analysis
│   ├── project_notes_sketches.pdf       # Project notes, sketches, and planning materials
│   └── project_roadmap.pdf              # Roadmap for the broader BI dashboard project
│
├── queries/                             # SQL scripts used for exploratory data analysis
│   ├── 00_init_database.sql             # Initializes or selects the database environment for Part II analysis
│   ├── 01_database_exploration.sql      # Explores database schemas, tables, columns, and available metadata
│   ├── 02_dimensions_exploration.sql    # Explores dimension values, categories, and business attributes
│   ├── 03_date_range_exploration.sql    # Identifies date boundaries and available order date ranges
│   ├── 04_measures_exploration.sql      # Calculates high-level business measures and key metrics
│   ├── 05_magnitude_analysis.sql        # Compares measure values across business categories
│   ├── 06_ranking_analysis.sql          # Identifies top and bottom performers using ranking logic
│   ├── 07_change_over_time_analysis.sql # Analyzes trends and measure changes across time
│   ├── 08_cumulative_analysis.sql       # Calculates running totals and cumulative performance
│   ├── 09_performance_analysis.sql      # Compares performance against prior periods or benchmarks
│   ├── 10_data_segmentation.sql         # Segments customers, products, or sales into analytical groups
│   └── 11_part_to_whole_analysis.sql    # Calculates contribution percentages and proportional performance
│
├── reports/                             # SQL scripts used to create final analytical report outputs
│   ├── 12_report_customers.sql          # Builds customer-level analytical reporting output
│   └── 13_report_products.sql           # Builds product-level analytical reporting output
│
└── README.md                            # Part II overview, requirements, EDA process, and repository structure

```
