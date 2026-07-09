# Dashboard Plan: Bike Retail Project 2

## Dashboard Purpose

_\* Goal (desired outcome of presentation):_

- Track KPIs (executive dashboard)
- Compare Regional Performance (geospatial analysis: map)
- Analyze Product Level Trends (product detail)
    - Revenue contribution: Accessories Vs Bikes
        - Point out that accessories are main earners 
        - Show which products are active (to ensure that high performers are active)
        - Show top 10 products with low profit margins that are active

- Identify High-Value Customers (customer detail)
    - Customer acquisition over the years
        - Show that there has been a large decline in new customer acquisition

<br>

This is way too much for one page. Thus, we need to create a multi-page dashboard.

<br>

**IMPORTANT NOTE**: The purpose of our dashboard is for managers to take the dashboard and explore the different metrics using the data.

- It is to establish a broad/general view of the business.
- Not to create a specific narrative or highlight a specific are for improvement

<br>

The purpose of our dashboard is to give an overall snapshot of operations while pointing out dangerous trends that are hurting the company which we might not be aware of.

- Realign product strategy
- Get snapshot of overall health of company
- Get snapshot of operations base
- Get snapshot of customer retention and acquisition to perhaps re-evaluate customer retention strategy (or develop this)

<br>

* * *

<br>

## Three Key Questions

1. Type of data:
    - time series
        - For dashboard 1
            - Revenue across time: trend-line & forecast
            - KPI cards for all-time stats (not real KPI cards)
            - Context KPI cards comparing previous month performance to current month (based on target measures)
        - For dashboard 4
            - Show customer acquisition over the years (new customers)
            - Show repeat customers for bikes (customer retention)

    - categorical
        - For dashboard 1
            - Orders by category
            - Part-to-whole analysis table from scripts showing the revenue by categories
        - For dashboard 3
            - Table of top 10 products with: Orders (bars), Revenue, Return (rate)
            - Performance of 3 bike models across years (based on yearly targets)
            - Performance of top 10 accessories across years (based on yearly targets)
            - Top 10 products that are active with lowest profit margins AND low sales (establish what low sales means)

    - geospatial
        - For dashboard 2
            - Create a map that highlights density of customers from states
            - Donut chart that shows the breakdown for overall sales by sales channel

    - hierarchies
        - For dashboard 1
            - Add date hierarchy to the revenue chart so individuals can drill down

2. What are we trying to communicate:
    - Comparisons
    - Composition
3. Who is the audience:
    - Managers

_<br>
_

_

* * *

<br>
_

## Dashboard Planning

We can start drawing the dashboard on scratch pad to get an idea for what we want.

- We design a scratch version for every dashboard we wish to create

<br>

When we begin to think of how to assemble the components of a dashboard, it is good to start thinking about the [[reading pattern]].

- How the viewers eye moves across the screen

<br>

### Exec Dashboard (1 out of the 4 views we plan to create)

- Company logo at the top left corner
- KPI cards at the very top
- Left middle - a nice trending line chart representing Revenue (where eyes usually go after top row)
    - With a date hierarchy so users can drill up or down (granularity)
    - Super important to include context (so include some additional KPI cards below the chart. Context is crucial since we do not know if our KPI numbers are good or bad on their own (past metrics, forecast target metrics etc.)
        - KPI cards could be: Current month revenue, previous month revenue, MoM revenue

<br>

**NOTE**: Get more and more granular as we move through the reading pattern

<br>

- Thus, to the right of this chart (middle middle) we can start breaking down this revenue by breaking down product category
    - Part-to-whole analysis table from scripts showing the revenue by categories
- We do not want to get too technical, but right under this, we can have something like the top 10 products by revenue displayed here (with conditional formatting)

<br>

We now need to think about the link between page-to-page; How are we going to do this and establish continuity and flow?

- One the left side of our dashboard, we can include a sliver that crosses from top to bottom and has buttons to navigate from page to page in our dashboard.

<br>

### Map: Regional Performance (2 out of the 4 views we plan to create)

- We will place a map on the view with slicers at the top (date to see how territories have changed over time)
- Create a map that highlights density of revenue for states
- Donut chart that shows the breakdown for overall sales by sales channel
- We can have gauges for revenue (part of whole) for each of the sales channels
    - When we select a state, the gauge adjusts to that condition

<br>

### Products (3 out of the 4 views we plan to create)

- Table of top 10 products with: Orders (bars), Revenue, Return (rate)
- Performance of 3 bike models across years (based on yearly targets) (three separate graphs)
- Donut chart (3 bikes revenue) to visualize Sales revenue adaptive to specific date
- Performance of top 10 accessories across years (based on yearly targets)
- Top 10 products that are active with lowest profit margins AND low sales (establish what low sales means)
- Scatter Plot: Accessories comparing revenue (sum/total) and profit margin of each accessory
    - For the purpose of visualizing what products we could potentially cut out and which we need to keep (in quadrants).
    - We can color the accessory points as red if inactive and green if active (great visual)

<br>

### Customers (4 out of the 4 views we plan to create)

We can start with some high-level metrics

- Show customer acquisition over the years (new customers)
- Show repeat customers for bikes (customer retention)
- Customer type from SQL script data\_segmentation

<br>

[[Notes for the Dashboard]]
