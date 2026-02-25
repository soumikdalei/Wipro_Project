import pandas as pd

# --------------------------
# 1. EXTRACT
# --------------------------
customers = pd.read_csv("data/customers.csv")
policies = pd.read_csv("data/policies.csv")
claims = pd.read_csv("data/claims.csv")
dates = pd.read_csv("data/data_dimension.csv")

# --------------------------
# 2. TRANSFORM
# --------------------------

# Clean missing values (if any)
customers.fillna("Unknown", inplace=True)
policies.fillna(0, inplace=True)
claims.fillna(0, inplace=True)

# Add custom fraud/risk rule
def compute_fraud_probability(row):
    if row['claim_amount'] > 200000:
        return 0.85
    elif row['claim_amount'] > 100000:
        return 0.45
    else:
        return 0.10

claims['fraud_probability'] = claims.apply(compute_fraud_probability, axis=1)

# Normalize status to upper-case
claims['claim_status'] = claims['claim_status'].str.upper()

# --------------------------
# 3. LOAD (Write cleaned files)
# --------------------------
claims.to_csv("data/claims_cleaned.csv", index=False)
customers.to_csv("data/customers_cleaned.csv", index=False)
policies.to_csv("data/policies_cleaned.csv", index=False)
dates.to_csv("data/date_dimension_cleaned.csv", index=False)

print("ETL processing complete. Cleaned files generated!")