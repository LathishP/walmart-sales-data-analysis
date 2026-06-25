# walmart-sales-data-analysis
<img width="2720" height="1680" alt="walmart_sql_pipeline" src="https://github.com/user-attachments/assets/46f99377-cd53-4e48-940c-92212bd11252" />
# 🛒 Walmart Sales Data Analysis — End-to-End Python + SQL Project

An end-to-end data analysis project that extracts Walmart sales data from Kaggle, processes and cleans it using Python, loads it into MySQL, and solves real-world business problems using advanced SQL queries.

---

## 📁 Project Structure

```
project_walmart/
│
├── project.ipynb               # Jupyter notebook — ETL pipeline & data cleaning
├── MySql queries.sql           # SQL file — 10 business problem queries
├── walmart.csv                 # Raw dataset (downloaded from Kaggle)
├── walmart_clean_data.csv      # Cleaned dataset after Python preprocessing
├── walmart_sql_pipeline.png    # Project pipeline architecture diagram
├── walmart business_problems.pdf  # PDF of all business problem questions
├── walmart-10k-sales-datasets.zip # Original Kaggle download archive
├── requirements.txt            # Python dependencies
└── README.md                   # Project documentation
```

---

## 🔄 Project Pipeline

```
Kaggle API  →  Python (Clean & Transform)  →  MySQL  →  SQL Analysis
```

1. **Extract** — Download the Walmart 10K dataset via Kaggle API
2. **Transform** — Clean and preprocess data using Pandas
3. **Load** — Push cleaned data into MySQL using SQLAlchemy + PyMySQL
4. **Analyse** — Solve 10 business problems using advanced SQL

---

## ⚙️ Tech Stack

| Layer | Tool |
|-------|------|
| Data Source | Kaggle API |
| Data Processing | Python, Pandas |
| Database Engine | SQLAlchemy |
| MySQL Driver | PyMySQL |
| Database | MySQL 8 (`walmart_db`) |
| Notebook | Jupyter (`.ipynb`) |

---

## 🚀 Getting Started

### 1. Clone or download the project

```bash
cd Desktop/project_walmart
```

### 2. Install dependencies

```bash
pip install -r requirements.txt
```

### 3. Set up Kaggle API

- Go to [kaggle.com](https://www.kaggle.com) → Account → Create API Token
- Place the downloaded `kaggle.json` in `~/.kaggle/`

### 4. Download the dataset

```bash
python -m kaggle datasets download -d najir0123/walmart-10k-sales-datasets
```

### 5. Set up MySQL

Create the database in MySQL Workbench or CLI:

```sql
CREATE DATABASE walmart_db;
```

Update your connection string in `project.ipynb` if needed:

```python
engine_mysql = create_engine("mysql+pymysql://root:<your_password>@localhost:3306/walmart_db")
```

### 6. Run the notebook

Open `project.ipynb` in Jupyter and run all cells top to bottom. This will:
- Unzip the dataset
- Load and clean the data
- Push it to MySQL

### 7. Run SQL queries

Open `MySql queries.sql` in MySQL Workbench and execute the business problem queries.

---

## 🧹 Data Cleaning Steps (Python)

Performed inside `project.ipynb`:

- Removed duplicate rows
- Dropped rows with missing values
- Cleaned `unit_price` column (stripped `$` symbol, cast to `float`)
- Engineered new `total` column: `unit_price × quantity`
- Exported cleaned data to `walmart_clean_data.csv`

---

## 📊 Business Problems Solved (SQL)

| # | Question |
|---|----------|
| Q1 | Payment methods, transaction count & quantity sold |
| Q2 | Highest-rated category per branch |
| Q3 | Busiest day per branch by transaction count |
| Q4 | Total quantity sold per payment method |
| Q5 | Min, max & avg rating by city and category |
| Q6 | Total profit per category (highest to lowest) |
| Q7 | Most common payment method per branch |
| Q8 | Sales shift analysis — Morning / Afternoon / Evening |
| Q9 | Top 5 branches with highest revenue decline YoY |
| Q10 | Month-over-month revenue growth percentage |

**SQL concepts used:** `GROUP BY`, Aggregation functions, Window functions (`RANK`, `LAG`), Date functions, CTEs, Subqueries, `CASE` expressions

---

## 📦 Requirements

```
pandas>=2.0.0
sqlalchemy>=2.0.0
pymysql>=1.1.0
kaggle>=1.6.0
```

Install with:

```bash
pip install -r requirements.txt
```

---

## 📌 Notes

- The raw dataset contains ~10,000 Walmart sales records
- MySQL database name: `walmart_db`, table name: `walmart`
- Default connection: `localhost:3306` with user `root`
- `psycopg2` is not required — this project uses **MySQL only**

---

## 🙋 Author

**Pandipatla Lathish**
MCA Student | Aspiring Data / IT Professional, India

