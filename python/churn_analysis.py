import pandas as pd
import matplotlib.pyplot as plt

# Load dataset
df = pd.read_csv("../data/telecom_churn.csv")

# Basic information
print("Dataset Shape:", df.shape)
print("\nMissing Values:")
print(df.isnull().sum())

# Churn distribution
churn_counts = df["churn"].value_counts()

print("\nChurn Distribution:")
print(churn_counts)

# Churn rate
churn_rate = (df["churn"].eq("Yes").mean()) * 100

print(f"\nOverall Churn Rate: {churn_rate:.2f}%")

# Churn by contract
contract_churn = pd.crosstab(
    df["contract"],
    df["churn"],
    normalize="index"
) * 100

print("\nChurn Percentage by Contract:")
print(contract_churn.round(2))

# Average monthly charges
avg_charges = df.groupby("churn")["monthly_charges"].mean()

print("\nAverage Monthly Charges by Churn:")
print(avg_charges.round(2))

# Churn by tenure group
df["tenure_group"] = pd.cut(
    df["tenure_months"],
    bins=[0, 6, 12, 24, 72],
    labels=["0-6 Months", "7-12 Months", "13-24 Months", "24+ Months"]
)

tenure_churn = pd.crosstab(
    df["tenure_group"],
    df["churn"],
    normalize="index"
) * 100

print("\nChurn Percentage by Tenure:")
print(tenure_churn.round(2))

# Visualization
churn_counts.plot(kind="bar")

plt.title("Customer Churn Distribution")
plt.xlabel("Churn")
plt.ylabel("Number of Customers")
plt.xticks(rotation=0)
plt.tight_layout()
plt.show()
