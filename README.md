# DBT E-Commerce Analytics Pipeline

A production-grade data pipeline built with dbt, MySQL, and GitHub Actions CI/CD.
Models a real-world e-commerce scenario with full data quality testing and documentation.

## Tech Stack
| Tool | Purpose |
|---|---|
| MySQL 8.0 | Data warehouse |
| dbt Core | Data transformation |
| GitHub Actions | CI/CD pipeline |
| dbt-utils | Utility macros |
| dbt_expectations | Advanced data quality tests |

## Project Architecture

### Data Flow

```
MySQL Raw Tables --> Staging --> Intermediate --> Marts --> BI/Reports
```

### Layer Responsibilities
| Layer | Models | Purpose |
|---|---|---|
| Staging | stg_* | Light cleaning, renaming, type casting |
| Intermediate | int_* | Business logic, joins, aggregations |
| Marts | fct_*, dim_* | Final tables for consumption |

## Data Model
### Fact Tables
- `fct_orders` — one row per order with payment and customer info

### Dimension Tables
- `dim_customers` — customer profiles with lifetime value and segmentation
- `dim_products` — product catalog with sales statistics

## Business Questions This Project Answers
- Who are our highest value customers?
- Which products generate the most revenue?
- What is the payment method breakdown across orders?
- Which orders are completed vs pending vs returned?
- What is the lifetime value of each customer?

## Data Quality
This project implements two layers of testing:
- **Generic tests** — uniqueness, not null, referential integrity
- **Singular tests** — custom business logic (payment amount matching)

## CI/CD Pipeline
Every pull request triggers:
1. Spins up a fresh MySQL container
2. Loads raw seed data
3. Installs dbt and dependencies
4. Creates profiles.yml securely from environment
5. Runs all dbt models
6. Runs all data quality tests
7. Fails the PR if any test breaks

## Project Structure
```
dbt_ecommerce/
    models/
        staging/
            sources.yml              # source declarations
            schema.yml               # staging tests and descriptions
            stg_customers.sql
            stg_orders.sql
            stg_order_items.sql
            stg_products.sql
            stg_payments.sql
        intermediate/
            int_orders_with_items.sql
            int_customer_orders.sql
        marts/
            schema.yml               # mart tests and descriptions
            fct_orders.sql
            dim_customers.sql
            dim_products.sql
    tests/
        assert_payments_match_orders.sql
    setup/
        init_raw_data.sql            # raw data for CI environment
    .github/
        workflows/
            dbt_ci.yml               # GitHub Actions workflow
    dbt_project.yml                  # project configuration
    profiles.yml.example             # profiles template (safe to commit)
    .gitignore
    README.md
```

## How to Run Locally
```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/dbt-ecommerce.git
cd dbt-ecommerce

# Create virtual environment
python -m venv venv
venv\Scripts\activate  # Windows
source venv/bin/activate  # Mac/Linux

# Install dependencies
pip install dbt-mysql
dbt deps

# Configure profiles.yml (see profiles.yml.example)
# Run the pipeline
dbt run
dbt test

# Generate and serve docs
dbt docs generate
dbt docs serve
```

## Setup
Copy `profiles.yml.example` to `~/.dbt/profiles.yml` and update
with your MySQL credentials.

![Lineage DAG](assets/lineage.png)
