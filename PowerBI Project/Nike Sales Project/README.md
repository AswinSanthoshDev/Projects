# 🏷️ Nike Sales Analytics Dashboard

## 📌 Project Overview

**Project Name:** Nike Sales Analytics Dashboard  

**Objective:**  
To analyze and consolidate Nike sales data into a structured analytical model and develop a multi-page Power BI dashboard that delivers actionable insights across executive performance, sales trends, product performance, regional contribution, customer segments, and profit leakage.

**Dataset:**  
Nike Sales Dataset (CSV format) containing historical, transaction-level sales data across products, regions, channels, customers, discounts, returns, and costs.

The primary goal of this project is to transform raw sales data into a decision-support system that enables stakeholders to monitor performance, identify inefficiencies, and optimize business strategies. :contentReference[oaicite:0]{index=0}

---

## 📊 Dataset Summary

- **Rows / Columns:** 2501 rows × 13 columns  
- **Dataset Type:** Medium-sized transactional dataset suitable for Power BI analysis  

### Key Characteristics
- Highly structured dataset ideal for a **Star Schema** model  
- Supports multi-dimensional analysis across:
  - Time  
  - Product  
  - Region  
  - Channel  
  - Gender  
  - Size  
- Enables both executive-level summaries and detailed drill-down analysis  

---

## 🧹 Data Cleaning & Preparation

The following steps were performed to ensure data quality and analytical accuracy:

- Data type standardization for numeric, text, and date fields  
- Identification and handling of duplicate records  
- Missing values filled using **median** to avoid distortion from outliers  
- Negative `Units_Sold` values treated as **Returns**  
- Creation of derived columns and analytical measures  
- Normalization into **fact and dimension tables** to improve performance  

---

## 📋 Column-Wise Assessment Summary

### Sales & Revenue
- Revenue, Units Sold, Total Cost, and Profit validated for accuracy and consistency  

### Discounts
- Discount and Average Discount assessed to evaluate pricing strategy and margin impact  

### Returns
- Returns data analyzed to identify high-return products and quality gaps  

### Date Attributes
- Standardized to support trend, seasonality, and YoY analysis  

### Categorical Fields
- Product Line, Product Name, Region, Channel, Gender, and Size cleaned for consistency  

---

## 🧩 Data Model Overview

### Schema Type
- **Star Schema**

### Tables
- **Fact Table:** Fact_Sales  
- **Dimension Tables:**  
  - Dim_Date  
  - Dim_Product  
  - Dim_Region  
  - Dim_Channel  
  - Dim_Gender  

### Relationships
- One-to-many relationships between dimensions and fact table  
- Single-directional cross-filtering for performance optimization  

---

## 🧮 Key Measures & Calculations

Core measures used across the dashboard:

- Total Revenue  
- Total Units Sold  
- Total Profit  
- Profit Margin (%)  
- Total Cost  
- Total Returns  
- Average Discount  

These measures form the analytical foundation for all dashboard visuals.

---

## 🔍 Analysis & Insights

### 📈 Sales & Revenue Trends
- Clear seasonal patterns with distinct peak and low-performing months  
- Units sold do not always correlate with profit due to discounting effects  

### 🏀 Product Performance
- **Basketball** and **Running** product lines generate the highest profits  
- Some high-revenue products operate on lower margins due to aggressive discounts  

### 🌍 Regional Performance
- **Mumbai** and **Bangalore** are top revenue-contributing regions  
- Certain regions show strong revenue but weaker margins due to higher costs  

### 🛒 Channel Performance
- Retail channel delivers higher profitability  
- Online channel shows high volume but lower margins  

### 💸 Discounts & Profit Leakage
- Higher discounts significantly reduce profit margins  
- High return rates increase operational costs and reduce profitability  

---

## ✅ Conclusions

This project successfully transforms raw Nike sales data into a structured, insight-driven analytics solution.

**Key takeaways:**
- Revenue growth is uneven across products, regions, and channels  
- Profitability is heavily influenced by discount strategies  
- Returns and costs are major contributors to profit leakage  

---

## 🎯 Recommendations

- **Pricing Strategy:** Optimize discount levels for low-margin, high-volume products  
- **Product Focus:** Invest more in high-margin lines such as Basketball and Running  
- **Regional Strategy:** Improve cost efficiency in regions with strong revenue but low margins  
- **Channel Optimization:** Increase online profitability through better pricing and cost control  
- **Returns Management:** Investigate high-return products to reduce losses  

---

## 📊 Dashboard Pages

1. **Executive Overview**  
2. **Time & Sales Performance**  
3. **Product & Size Analysis**  
4. **Customer, Region & Channel Insights**  
5. **Returns, Discount & Profit Leakage**  

---

## ⚠️ Notes & Limitations

- Analysis is based solely on historical sales data provided  
- No external data (marketing spend, supply chain costs, competitors) included  
- Dashboard is **descriptive and diagnostic**; predictive forecasting is out of scope  

---

## 🛠 Tools Used

- Power BI  
- Power Query  
- DAX  
- CSV Dataset  

---

## 📁 Repository Structure (Suggested)
