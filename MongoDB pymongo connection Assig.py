import pandas as pd
from pymongo import MongoClient

# Fixed path issue
csv_file = r"D:\MongoDB Assigment\superstore.csv"

# Read CSV with correct encoding
df = pd.read_csv(csv_file, encoding="latin-1")

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client["superstore_db"]
collection = db["Orders"]

# Convert to records and insert
data = df.to_dict(orient="records")
collection.delete_many({})
collection.insert_many(data)

print(f"Inserted {len(data)} records into MongoDB successfully!")
