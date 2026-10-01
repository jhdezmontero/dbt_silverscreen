# 🎬 Silver Screen Analytics Project (dbt)

Welcome to the **Silver Screen** data transformation project! This repository contains a complete dbt (data build tool) pipeline designed to ingest, clean, unify, and model operational data for a newly acquired chain of movie theaters in New Jersey.

---

## 📌 Business Problem & Context

As a BI Analyst for a major entertainment company that recently acquired **‘Silver Screen’** (a chain of three movie theaters in New Jersey), management needs to evaluate the operational efficiency and profitability of these locations. 

Specifically, leadership wants to understand the relationship between **movie rental costs** and **ticket revenue generated** across each location on a monthly basis. To answer this, this project builds a unified reporting model that aggregates monthly performance per movie across all theaters.

---

## 📂 Data Sources

The raw data is provided across five distinct sources, each requiring specific handling due to varying formats and levels of granularity:

1. **`movie_catalog`**: Detailed metadata for movies released in 2024 (titles, genres, studios, budgets, runtimes).
2. **`invoices`**: Monthly rental cost invoices issued by studio accountants for showing specific movies at various locations.
3. **`nj_001`**: Transaction-level ticket sales data for Location №1 (timestamp-based granularity requiring extraction and monthly aggregation).
4. **`nj_002`**: Daily aggregated ticket sales data for Location №2.
5. **`nj_003`**: Transaction-level product sales data for Location №3 (requiring filtering for ticket products and extracting embedded movie IDs).

---

## 🏗️ dbt Project Architecture

The project is organized into three sequential layers, ensuring clean separation of concerns and maintainability:

* **Staging (`models/staging/`)**: Connects directly to raw sources, standardizes column names, and handles initial data cleaning (views).
* **Intermediate (`models/intermediate/`)**: Unifies the disparate transaction structures from locations `nj_001`, `nj_002`, and `nj_003` into a consistent monthly format (views).
* **Mart (`models/mart/`)**: Combines unified ticket sales with movie metadata and monthly rental costs to produce the final reporting model (tables).

---

## 📊 Final Target Table Schema

The final mart model structures the data into a single, comprehensive table containing the following fields:

* `movie_id`: Unique identifier for the movie.
* `movie_title`: Title of the movie.
* `genre`: Category/genre of the movie.
* `studio`: Production studio responsible for the film.
* `month`: The specific operating month (`YYYY-MM-DD`).
* `location`: The theater location identifier (`NJ_001`, `NJ_002`, `NJ_003`).
* `rental_cost`: The monthly rental cost for showing the movie.
* `tickets_sold`: Total number of tickets sold.
* `revenue`: Total revenue generated from ticket sales.

---

## 🚀 Getting Started

1. **Install dependencies:**

```bash
dbt deps
```

## Run the Pipeline
```bash 
dbt build
```

## View documentation

```bash 
dbt docs generate
dbt docs serve
```