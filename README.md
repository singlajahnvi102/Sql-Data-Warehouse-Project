SQL Data Warehouse & Analytics Project

📌 Project Overview

This is a practice Data Warehouse project inspired by the SQL Data Warehouse project by Data With Baraa.

The project demonstrates how raw data from different source systems can be loaded, cleaned, transformed, integrated, and modeled into a structured data warehouse using SQL Server.

The project follows a Bronze → Silver → Gold architecture and uses a Star Schema in the Gold layer to prepare data for analytical reporting.

---

🎯 Project Objectives

The main objective of this project is to practice the end-to-end process of building a modern SQL Server Data Warehouse.

The project focuses on:

- Data ingestion
- Data cleansing
- Data transformation
- Data integration
- Data quality validation
- Data warehouse architecture
- Dimensional modeling
- Star Schema design
- SQL-based analytics

---

🏗️ Data Warehouse Architecture

The project follows a three-layer architecture:

Source Systems
      │
      ▼
┌──────────────┐
│ Bronze Layer │
│   Raw Data   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Silver Layer │
│ Cleaned Data │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Gold Layer  │
│ Star Schema  │
└──────┬───────┘
       │
       ▼
Analytical Reporting

## 📊 Project Documentation & Data Models

The project documentation includes the following diagrams:

- [Data Model](/Docs/Data_Model.png) — Gold-layer Star Schema showing fact and dimension relationships.
- [Data Flow](Docs/data%20flow.png) — Shows the movement of data through the Bronze, Silver, and Gold layers.
---

🥉 Bronze Layer

The Bronze layer stores the data in its raw form after loading it from the source systems.

Key Activities

- Load source CSV files into SQL Server
- Create raw/staging tables
- Preserve source data
- Perform initial data validation
- Implement data loading procedures

The Bronze layer provides the foundation for the transformation process.

---

🥈 Silver Layer

The Silver layer contains cleaned and transformed data.

Key Activities

- Clean data quality issues
- Handle null and invalid values
- Remove duplicates where required
- Standardize formats
- Transform columns
- Resolve inconsistencies
- Apply business rules
- Validate transformed data

The goal is to create clean and reliable data for the Gold layer.

---

🥇 Gold Layer

The Gold layer contains business-ready data designed for analytical use.

A Star Schema is created in this layer using dimension and fact views.

The model consists of:

- Fact tables/views — contain measurable business events and metrics.
- Dimension tables/views — contain descriptive information used to analyze the facts.

Star Schema

             ┌───────────────┐
             │ Dim Customer  │
             └───────┬───────┘
                     │
                     │
┌─────────────┐  ┌───▼───────────┐  ┌─────────────┐
│ Dim Product │──│  Fact Sales   │──│ Dim Date    │
└─────────────┘  └───▲───────────┘  └─────────────┘
                     │
                     │
             ┌───────┴───────┐
             │ Other         │
             │ Dimensions    │
             └───────────────┘

The Star Schema makes the warehouse easier to query and supports analytical reporting.

---

📊 Data Analytics

SQL queries are created using the Gold-layer data to demonstrate analytical capabilities.

The analytics focus on areas such as:

- Customer behavior
- Product performance
- Sales trends
- Sales metrics
- Customer and product analysis

The purpose of this section is to demonstrate how the dimensional model can be used for analytical reporting.

---

🔍 Data Quality

Data quality checks are performed throughout the transformation process.

Examples include:

- Checking for NULL values
- Identifying duplicate records
- Validating primary keys
- Checking foreign-key relationships
- Validating data types
- Identifying invalid or inconsistent values
- Checking data consistency between source and transformed data

---

🛠️ Tools & Technologies

- SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)
- Git
- GitHub
- CSV

---

📁 Project Structure

SQL-Data-Warehouse-Project/
│
├── datasets/
│   ├── CUST_AZ12.csv
│   ├── LOC_A101.csv
│   ├── PX_CAT_G1V2.csv
│   ├── cust_info.csv
│   ├── prd_info.csv
│   └── sales_details.csv
│
├── Docs/
│   ├── Data_Model.png
│   ├── data_integration_model.png
│   └── data_flow.png
│
├── scripts/
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   ├── proc_load_bronze.sql
│   │   └── ...
│   │
│   ├── silver/
│   │   ├── ddl_silver.sql
│   │   ├── proc_load_silver.sql
│   │   ├── quality_checks_silver.sql
│   │   └── ...
│   │
│   └── gold/
│       ├── ddl_gold.sql
│       └── ...
│
├── tests/
│   └── quality_checks_gold.sql
│
├── README.md
└── LICENSE

---

📚 Key Learning Outcomes

Through this project, I practiced:

- Data Warehouse concepts
- ETL/ELT processes
- Bronze, Silver, and Gold architecture
- Data cleansing and transformation
- Data quality validation
- SQL Server and T-SQL
- Stored procedures
- Data integration
- Dimensional modeling
- Fact and dimension tables
- Star Schema design
- Analytical SQL queries
- Git and GitHub project organization

---

🎓 Project Type

Practice / Learning Project

This project was created as a hands-on learning exercise and is inspired by the SQL Data Warehouse project taught by Data With Baraa.

The purpose of this project is to strengthen practical skills in SQL, Data Warehousing, ETL, dimensional modeling, and analytical data preparation.

---

👤 About Me

I am developing my skills in SQL, Data Analytics, Business Intelligence, and Data Warehousing through hands-on projects.

This project is part of my learning journey toward building practical and industry-relevant data skills.

---

📜 Credits

This project is inspired by the SQL Data Warehouse and Analytics project by Data With Baraa.

It is used for educational and practice purposes.
