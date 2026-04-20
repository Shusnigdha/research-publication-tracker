# 📊 Research Publication Tracker

---

## 🚀 **Overview**
This project presents an **end-to-end data engineering and analytics pipeline** that processes raw research publication data and transforms it into meaningful insights using an interactive Power BI dashboard.

It covers the complete flow from:
**Data Ingestion → Data Processing → Data Storage → Data Analysis → Visualization**

---

## 🎯 **Problem Statement**
With the growing volume of research publications, it is difficult to analyze trends, identify key contributors, and understand collaboration patterns. Raw publication data is often unstructured, making direct analysis inefficient.

This project builds a system to transform raw data into structured format and provide actionable insights through an interactive dashboard.

---

## 💡 **Solution**
The project implements a complete pipeline:

### 🔹 Data Ingestion
- Collects research publication data in JSON format via API  

### 🔹 Data Processing (PySpark)
- Parses and flattens nested JSON  
- Extracts relevant fields (title, authors, published date)  
- Handles missing and inconsistent data  

### 🔹 Data Transformation
- Converts data into structured tables:
  - `papers`  
  - `authors`  
  - `paper_author` (bridge table)  

### 🔹 Data Storage (PostgreSQL)
- Stores structured data in relational schema  
- Applies indexing for optimized performance  

### 🔹 Data Analysis (SQL)
- Uses joins, aggregations, and window functions  
- Creates OLAP table (`paper_summary`) for efficient querying  

### 🔹 Visualization (Power BI)
- Builds interactive dashboard with slicers and KPI cards  

---

## 📈 **Dashboard Features**

- 📊 **Publication Trend Analysis**  
- 👩‍🔬 **Top Contributing Authors**  
- 🤝 **Collaboration Distribution**  
- 📅 **Top Active Years**  

### 📌 KPI Metrics
- Total Publications  
- Total Authors  
- Average Authors per Paper  

### 🎛️ Interactive Filters
- Filter by Year  
- Filter by Author  
- Filter by Number of Authors  

---

## 🛠️ **Tech Stack**

### 🔹 Languages & Processing
- Python  
- PySpark  

### 🔹 Database
- PostgreSQL  

### 🔹 Querying & Transformation
- SQL (Joins, Aggregations, Window Functions)  

### 🔹 Visualization
- Power BI  

### 🔹 Tools
- VS Code  
- Google Colab  
- pgAdmin  
- Power BI Desktop  

---

## ⭐ **Key Highlights**

- Built a complete **end-to-end data pipeline**  
- Processed **semi-structured JSON data using PySpark**  
- Designed optimized **relational database schema**  
- Created **OLAP table (`paper_summary`)** for faster analytics  
- Performed **data quality checks** (duplicates, missing values)  
- Implemented **advanced SQL queries**:
  - Author ranking  
  - Collaboration analysis  
  - Yearly trends  
- Developed a **fully interactive Power BI dashboard**  
- Solved real-world BI challenges:
  - Data modeling issues  
  - Relationship handling  
  - Aggregation vs filtering  

---

## 🚀 **Future Improvements**

- Integrate **Apache Airflow** for pipeline automation  
- Add **citation-based metrics** (h-index, citation count)  
- Build **author collaboration network graph**  
- Deploy dashboard using **Power BI Service**  
- Develop a **Streamlit web application**  

---

## 📌 **Project Structure**


├── data/
├── notebooks/
├── sql/
├── dashboard/
└── README.md

---

## 🎯 **Conclusion**

This project demonstrates how raw, unstructured research data can be transformed into actionable insights using a scalable data pipeline and interactive visualization tools.

---
