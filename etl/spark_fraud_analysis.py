from pyspark.sql import SparkSession
from pyspark.sql.functions import avg

sf_options = {
    "sfUser": "SoumikDalei",
    "sfPassword": "Soumik26200345",
    "sfAccount": "jgvrpn-hx45865",
    "sfWarehouse": "COMPUTE_WH",
    "sfDatabase": "INSURANCE_DB",
    "sfSchema": "DWH"
}

spark = SparkSession.builder.appName("FraudAnalysis").getOrCreate()

df = spark.read.format("snowflake").options(**sf_options).option("dbtable", "FACT_CLAIMS").load()

result = df.groupBy("policy_id").agg(avg("fraud_probability").alias("avg_fraud_prob"))

result.show()