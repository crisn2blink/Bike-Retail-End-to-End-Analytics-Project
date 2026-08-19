# Bike Retail Sales Analysis

## Final Business Insights

### Business Objective

Evaluate historical sales performance across products, customers, sales channels, stores, and geographic markets to identify the primary drivers of company performance and highlight opportunities for revenue growth, customer acquisition, product optimization, and more effective resource allocation.

## The analysis covers sales activity from **January 1, 2023 through March 6, 2026**, across 1,000 orders, 60 product models, three sales channels, and six store locations.

## Executive Summary

* **Customer retention is strong, but customer acquisition has deteriorated sharply.** The company has only 120 customers, yet 92% are repeat bike customers and 98% have purchased accessories. At the same time, new-customer acquisition fell from 35 customers in 2024 to only 5 in 2025, with no new customers recorded in 2026.

* **Sales volume appears low relative to the company's operating footprint.** Only 1,000 orders were generated across the full analysis period despite the company operating six locations and three sales channels. Store-level revenue and quantities are also relatively similar across locations, suggesting the need to evaluate whether the current physical footprint is economically justified.

* **Channel performance suggests meaningful differences in product or price mix.** Dealer sales generate the highest revenue and store sales the lowest, despite all three channels selling approximately similar quantities. Online sales account for only 15% of total orders. This indicates that revenue differences may be driven more by what is being sold through each channel than by sales volume alone.

* **The product portfolio warrants further review.** Hybrid-bike sales have been declining, while 35 models are classified as high-margin products, including eight that are currently inactive. Product-level rationalization could help determine whether the current 60-model assortment is aligned with demand and profitability.

* **The existing customer base is geographically concentrated.** Texas, Florida, and North Carolina contain the largest customer populations, making territory strategy an important area for additional analysis.

---

# Key Insights & Recommendations

## 1. Strong customer retention is being undermined by weak customer acquisition

### Finding

The company serves a relatively small customer base of approximately **120 customers**, but the existing base is highly engaged: **92% of customers are repeat bike customers**, and **98% have purchased an accessory**. Average customer spend is approximately **$22,000**.

The larger concern is acquisition. New customers declined from **42 in 2023 to 35 in 2024 and only 5 in 2025**. No new customers are recorded for 2026.

### Business Implication

The business appears effective at generating continued purchasing activity from customers once they enter the customer base, but it is not replenishing or expanding that base at a sustainable rate.

If the acquisition decline continues, strong retention alone may not be sufficient to produce meaningful long-term growth.

### Recommended Action

Prioritize investigation of the **customer acquisition funnel** rather than focusing primarily on retention.

Determine whether the decline is being driven by reduced marketing activity, weaker lead generation, geographic limitations, channel performance, product-market fit, or another factor not available in the current dataset.

Because retention is already strong, improving acquisition may represent a larger growth opportunity than attempting to materially increase repeat purchasing among existing customers.

---

## 2. Sales volume may not justify the company's current physical footprint

### Finding

Only **1,000 orders** were generated across the entire analysis period, while the company operates **six locations** and three sales channels. Store locations also produce approximately similar revenue and sales quantities rather than showing clear high-performing and low-performing locations.

### Business Implication

The number of locations appears large relative to the company's overall transaction volume.

However, sales data alone cannot establish whether a location is economically unprofitable because the dataset does not include store-level operating expenses, labor costs, rent, or other fixed costs.

### Recommended Action

Conduct a **store-level profitability analysis** before expanding the physical footprint.

Compare each location's revenue and gross profit against its operating costs and strategic value. Locations should be evaluated for consolidation only if their economics do not justify maintaining them.

This analysis would allow management to determine whether resources currently supporting physical stores could generate greater returns through other channels or growth initiatives.

---

## 3. Dealer revenue outperformance may be driven by sales mix rather than higher volume

### Finding

The **Dealer** channel produces the highest sales revenue while the **Store** channel produces the lowest. However, all three channels sell approximately the same total quantity.

At the same time, only approximately **15% of orders originate online**.

### Business Implication

Because unit volume is similar across channels, Dealer revenue outperformance is unlikely to be explained simply by selling substantially more items.

The difference may instead result from **product mix, average selling price, customer type, or order composition**.

The relatively small online order share may also represent either an underdeveloped channel or simply a channel that plays a different role in the company's sales model.

### Recommended Action

Analyze **revenue per order, average selling price, product/category mix, and profit margin by channel** before shifting resources toward or away from any channel.

If Dealer sales are disproportionately concentrated in higher-value or higher-margin products, determine whether those successful product and customer patterns can be replicated through Store or Online channels.

Separately investigate the causes of low online penetration before assuming that increasing online sales would necessarily improve profitability.

---

## 4. The product portfolio should be evaluated for declining and underutilized products

### Finding

The company carries **60 product models across eight categories**, including three bike categories and five accessory categories.

Hybrid-bike sales have been steadily declining. Meanwhile, **35 models are classified as high-margin products**, but only 27 are active; eight high-margin models are inactive.

### Business Implication

The product portfolio may contain opportunities both to eliminate weak performers and to reconsider products that appear attractive from a margin perspective but are no longer active.

The decline in Hybrid Bikes also warrants investigation into whether the issue is category-wide demand, specific models, pricing, availability, or changing customer preferences.

### Recommended Action

Perform a **product portfolio rationalization analysis** using revenue, quantity sold, profit, profit margin, sales trend, and product status.

Products should then be classified into groups such as:

* Strong performers to retain and prioritize
* High-margin products with growth potential
* Declining products requiring investigation
* Low-volume / low-profit products that may be candidates for discontinuation

Inactive high-margin products should also be reviewed to determine why they were removed and whether reactivation would be commercially justified.

---

## 5. Geographic concentration creates an opportunity for a more deliberate territory strategy

### Finding

The largest customer populations are located in **Texas, Florida, and North Carolina**.

The overall customer base spans 13 states and 20 cities.

### Business Implication

The concentration of customers in a small number of states suggests that geographic performance is uneven.

This may reflect stronger market demand, better dealer relationships, greater brand awareness, existing store coverage, or other factors that cannot be determined from the current dataset alone.

### Recommended Action

Evaluate territory performance using **customers, orders, revenue, profit, and customer acquisition by state**.

Management should determine whether Texas, Florida, and North Carolina warrant additional investment because they are proven strong markets or whether successful characteristics from those states can be replicated in underpenetrated territories.

This analysis should also distinguish between markets with genuinely weak demand and markets that have simply received limited commercial attention.

---

# Additional Observation: Revenue Mix Requires Caution

Gloves are the highest revenue-generating category and substantially outperform the company's bike categories despite bikes being the company's primary product. The EDA also identifies gloves and helmets among the highest-volume products.
This finding should **not be interpreted as evidence that the company should strategically prioritize gloves over bikes**, because the synthetic dataset contains unrealistic pricing—for example, some basic accessories are priced above bikes.

The observation is therefore useful for demonstrating the analytical process, but product-strategy conclusions based specifically on relative revenue contribution should be treated cautiously.

---

# Analysis Limitations

The dataset was synthetically generated rather than sourced from an operating company. Some prices are therefore economically unrealistic, particularly among accessories. The values remain internally usable for demonstrating data modeling and analytical techniques, but certain business interpretations—especially comparisons driven heavily by price—should be considered illustrative rather than representative of an actual bicycle retailer.

The dataset also ends on **March 6, 2026**. As a result, the sharp decline visible at the end of the revenue trend reflects an incomplete year rather than evidence of a sudden business deterioration.
Finally, the data records **38 new customers in 2022 even though the first recorded order occurs on January 1, 2023**. This discrepancy should be investigated before using the 2022 customer count for acquisition-performance conclusions.

---

# Recommended Next Steps

1. **Customer acquisition analysis** — determine why new-customer growth collapsed after 2024 and identify the strongest acquisition opportunities.

2. **Product portfolio rationalization** — evaluate declining, low-volume, low-profit, inactive, and high-margin products to determine which models should be retained, promoted, reactivated, or discontinued.

3. **Channel economics analysis** — determine why Dealer revenue exceeds other channels despite similar unit volumes and evaluate the growth potential of Online sales.

4. **Store profitability analysis** — combine sales performance with operating-cost data to determine whether six physical locations are economically justified.

5. **Territory analysis** — evaluate why Texas, Florida, and North Carolina contain the largest customer populations and whether their performance can be replicated in other markets.
