# Olist E-commerce Data Analysis

## 📌 Project Overview

This project is an end-to-end data analysis project based on the Brazilian Olist E-commerce dataset.

The project focuses on transforming raw e-commerce data into a structured data model using SQL Server, performing data analysis, and building interactive Power BI dashboards to generate meaningful business insights.

The project covers the full data analysis workflow, from raw data preparation and database modeling to analysis, visualization, and business insights.

---

## 📊 Dataset

The dataset was obtained from Kaggle and contains information about Olist's e-commerce operations, including:

- Customers
- Orders
- Order Items
- Products
- Sellers
- Payments
- Reviews
- Geolocation

Dataset Source:
Kaggle - Brazilian E-Commerce Public Dataset by Olist

---

## 🛠️ Tools & Technologies

- SQL Server
- SQL
- Power BI
- Power Query
- DAX
- Data Modeling
- Excel / CSV
- Git & GitHub

---

## 🗄️ Data Preparation & SQL Server

The original dataset consisted of multiple CSV files.

I imported the raw data into SQL Server and created a structured data model for analysis.

I also created additional tables, including a Date Dimension, to support time-based analysis and reporting.

The database was organized using a dimensional modeling approach with fact and dimension tables.

### Data Modeling

The model includes:

- Fact Orders / Order Items
- Customer Dimension
- Product Dimension
- Seller Dimension
- Date Dimension
- Other supporting dimensions

Relationships and primary/foreign keys were created to connect the different tables and support efficient analysis.

---

## 🔄 Data Transformation

The data was cleaned and transformed before analysis.

The main steps included:

- Handling missing values
- Removing duplicates where necessary
- Data type transformations
- Creating relationships between tables
- Creating calculated columns
- Creating a Date Dimension
- Preparing data for Power BI analysis

---

## 📈 SQL Analysis

SQL was used to extract and analyze the data and answer business-related questions.

The analysis included:

- Sales analysis
- Profit analysis
- Customer analysis
- Product performance
- Order analysis
- Delivery performance
- Time-based analysis
- Customer segmentation

The SQL queries used throughout the project are included in the repository.

---

## 👥 Customer RFM Analysis

I performed an RFM (Recency, Frequency, Monetary) analysis to segment customers based on their purchasing behavior.

Customers were segmented into groups such as:

- Champions
- Loyal Customers
- At Risk
- Lost Customers

This analysis helps identify different customer groups and understand their purchasing behavior.

---

## 📊 Power BI Dashboards

The project includes three interactive Power BI dashboards.

### 1. Executive Dashboard

Provides an overview of the business performance, including:

- Sales
- Profit
- Orders
- Customers
- Time-based performance
- Product/category performance

### 2. Customer / RFM Dashboard

Focuses on customer behavior and segmentation.

It includes:

- RFM analysis
- Customer segments
- Recency
- Frequency
- Monetary analysis
- Customer distribution

### 3. Product Dashboard

Focuses on product and category performance.

It includes:

- Product performance
- Category analysis
- Sales
- Profit
- Order trends
- Top-performing products/categories

The dashboards are interactive and include filters, navigation buttons, tooltips, and drill-through functionality.

---

## 💡 Key Insights

Some of the key findings from the analysis include:

- November 2017 recorded the highest profit during the analyzed period.
- Health & Beauty and Watches & Gifts were among the notable categories in the analysis.
- Most delivered orders arrived earlier than their estimated delivery date.
- Customer segmentation revealed distinct groups including Champions, Loyal Customers, At Risk, and Lost Customers.
- Delivery performance and customer behavior were analyzed to identify potential business opportunities.

---

## 📁 Repository Structure

```text
Olist-Ecommerce-Data-Analysis/
│
├── SQL/
│   └── Olist_Analysis.sql
│
├── PowerBI/
│   └── Olist_Dashboard.pbix
│
├── Screenshots/
│   ├── Executive_Dashboard.png
│   ├── Customer_RFM_Dashboard.png
│   └── Product_Dashboard.png
│
└── README.md
