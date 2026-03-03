# 🏭 Tableau Capstone Project – Manufacturing Operations Dashboard

## 📌 Project Summary
This project analyzes manufacturing operations performance across multiple plants using a structured Star Schema data model.  

The dashboard provides visibility into production efficiency, quality performance, downtime reliability, supplier risk, and resource utilization to support data-driven operational decision-making.

---

## 🎯 Business Objective
Manufacturing leadership requires centralized reporting to:

- Monitor plan attainment and production efficiency
- Identify scrap and quality loss drivers
- Analyze downtime root causes
- Evaluate supplier performance impact
- Compare plant-level performance

This dashboard enables actionable operational insights.

---

## 🗂 Dataset Overview
- **Domain:** Manufacturing Operations  
- **Records:** 7,500 production-level rows  
- **Data Model:** Star Schema  
- **Fact Table:** Production & Operational Metrics  
- **Dimension Tables:**  
  - Date  
  - Plant  
  - Product  
  - Machine  
  - Shift  
  - Supplier  
  - Scrap Reason  
  - Downtime Reason  

The dataset was cleaned, standardized, and normalized prior to dashboard development.

---

## 📊 Dashboard Pages

### 1️⃣ Executive Operations Overview
- Plan Attainment %
- Yield %
- Scrap Rate %
- Downtime %
- Trend monitoring over time

### 2️⃣ Production & Throughput
- Output vs Plan comparison
- Machine-level throughput analysis
- Shift performance breakdown

### 3️⃣ Quality & Yield
- Scrap rate trends
- QA score analysis
- Pareto of scrap reasons
- SKU-level yield comparison

### 4️⃣ Downtime & Reliability
- Downtime trend analysis
- Top downtime drivers
- Machine reliability assessment

### 5️⃣ Supplier & Material Risk
- Supplier quality comparison
- Scrap contribution by supplier
- Supplier performance variability

---

## 📈 Key KPIs

- **Plan Attainment %** = Actual Output / Planned Output  
- **Yield %** = Good Units / Total Production Units  
- **Scrap Rate %** = Scrap Units / Total Units  
- **Downtime %** = Downtime Minutes / Planned Runtime  
- **Energy per Good Unit**  
- **Water per Good Unit**

---

## ⚙️ Features Used in Tableau

- Star Schema Data Modeling
- LOD Expressions
- Table Calculations
- Parameters
- Dashboard Actions (Filter, Highlight, Navigation)
- Story Page
- Cross-filtering
- KPI Cards

---

## 🛠 Data Preparation

- Data cleaning and standardization
- Data type corrections
- Calculated field creation
- LOD expression development
- Normalized dimensional modeling

---

## 🔍 Key Insights

- Production plan attainment indicates optimization opportunities.
- Scrap is concentrated in a limited number of root causes.
- Mechanical and changeover issues drive downtime.
- Supplier variability influences quality outcomes.
- Resource efficiency varies across plants.

---
---

