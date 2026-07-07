# README EDA Bike Project

## Intro/Welcome

Welcome to the **EDA Bike Project** repository! This project demonstrates a comprehensive approach to EDA; from simple tasks dealing with _categorical analysis_ to more complex operations such as _part-to-whole analysis_, _cumulative running averages_ and _product-performance analysis_. Designed as a portfolio project that highlights industry best practices for data analysis.

<br>

## **📖 Project Overview**

#### **Objective of Project**

Perform EDA (Exploratory Data Analysis) to derive business insights that will be used to ultimately create a business dashboard (in “Third entry: Bike Dashboard Project)\*

<br>

###### \*Reference “Project Background” section

<br>

#### **Project Specifications**

Data Sources

- SQL Views
    - The views used to perform the EDA are those created from “First entry: Bike Data Warehouse Project”\*\*

<br>

###### \*\*Reference “Project Background” section

<br>

Skills Employed

- Data Analytics
- SQL Coding
- AI Prompt Engineering (for verification purposes)

<br>

## 🛠️ Project Background

This project (Bike EDA Project) conforms one of three entries that make up the overall “Bike Project”.

- First entry: Bike Data Warehouse Project (not included in this repository)
- Second entry: Bike EDA Project (covered by this repository)
    - **This entire repository deals with only this second entry**
- Third entry: Bike Dashboard Project (not included in this repository/separate repository)

<br>

The aim of all three entries of the Bike Project is to go through the entirety of the data lifecycle from the very start of aggregating the data to ultimately presenting business insights derived from our data in an organized and structured dashboard. The aim of the dashboard being to provide business insights to the stakeholders of the Bike company.

<br>

## 🎯 EDA Analysis Breakdown

1. ### **Dimension Exploration:**
    - Identify the unique values (or categories) in each dimension
    - Recognizing how data might be grouped or segmented, which is useful for later analysis
    - Understanding the granularity of our dimensions as well as the hierarchical layers

<br>

2. ### **Date Exploration**: Find the dates for the range of orders
    - Identify the earliest and latest dates (boundaries)
    - Understand the time-span

<br>

Syntax:

MIN/MAX \[date dimensions\]

<br>

3. ### **Measure Exploration**
    - Calculate and find out the key metrics of our business (Big Numbers)
    - Highest level of aggregation/lowest level of details

<br>

Examples:

- SUM(Sales)
- AVG(price)
- SUM(quantity)
- COUNT(DISTINCT customer\_key)

<br>

4. ### **Magnitude Analysis**
    - Here we will start putting things together and really begin our analysis (this is basic).
    - Magnitude analysis is comparing the measure values **by categories**.
    - Helps us to understand the importance of different categories.

<br>

Scenarios:

- Total sales by country
- Total quantity by category
- Average price by products
- Total orders by customers

<br>

5. ### **Ranking Analysis**
    - Order the values and dimensions by measures
    - Top performers|Bottom performers

<br>

Examples:

- RANK \[dimension\] by \[measure\]
- RANK countries by total\_sales
- TOP 5 products by quantity
- BOTTOM 3 customers by total\_sales

<br>

6. ### **Change Over Time**  
    - Technique to analyze how a measure evolves over time
    - Helps to track trends and identify seasonality

<br>

Scenarios:

- Total sales by year
- Average cost by month

<br>

7. ### **Cumulative Analysis**: Running total & Moving Average
    - Used to aggregate the data progressively across time
    - Helps to understand whether our business is growing or declining
    - Very similar to change over time but cumulative

<br>

Case Use:

- Aggregate \[cumulative measure\] By \[date dimension\]

<br>

8. ### **Performance Analysis (YoY Analysis)**
    - Process of comparing the current value with a target value. 

<br>

Case Use:

- Current\[measure\] - Target\[measure\]

<br>

Scenarios:

- Current sales - Average sales
- Current year sales - previous year sales
- Current sales - lowest sales
- Highest sales - Current sales

<br>

9. ### **Part-to-Whole Analysis**
    - Proportional Analysis: Analyze how an individual part is performing compared to the overall, allowing us to understand which category has the greatest impact on the business.

<br>

Case Use:  

- (\[measure\]/Total \[measure\]) \* 100 BY \[dimension\]

<br>

Examples:

- (Sales/Total Sales) \* 100 By Category
- (Quantity/Total Quantity) \* 100 By Country

<br>

10. ### **Data Segmentation Analysis**
    - Group the data based on a specific range
    - Helps to understand the correlation between two measures

<br>

Case Use:

- \[Measure\] by \[Measure\]

<br>

Scenarios:

- Total products By Sales Range
- Total customers By Age

<br>

THE RESULTS OF THE EDA ARE FOUND UNDER THE "RESULTS" TAB IN THIS REPOSITORY

## 📂 Repository Structure
```
data-warehouse-project/  
│  
├── source documents/                                      # Raw datasets used for the project
│  
├── eda scripts/                                           # Individual scripts for all the types EDA used
│   ├── Part_Whole_analysis.sql              
│   ├── change_over_time.sql           
│   ├── cumulative_analysis.sql
│   ├── data_segmentation_analysis.sql
│   ├── date_range_exploration.sql
│   ├── dimensions_exploration.sql
│   ├── magnitude_analysis.sql
│   ├── measures_exploration.sql
│   ├── performance_analysis.sql
│   ├── ranking_analysis.sql

│  
├── view scripts/                                         # SQL scripts for views from which the EDA analysis was performed  
│   ├── gold.dim_customers 
│   ├── gold.dim_products
│   ├── gold.fact_sales

├── Results/                                              # The overall results for the EDA
│   ├── Final EDA Results
```  
\---
