import os
import json
from google.cloud import bigquery
import psycopg2

def trigger_pgtobq_sync(event, context):
    # Environment variables or Secret Manager values
    bq_dataset = os.getenv("BQ_DATASET")
    bq_table = os.getenv("BQ_TABLE")
    pg_host = os.getenv("PG_HOST")
    pg_port = os.getenv("PG_PORT", 5432)
    pg_db = os.getenv("PG_DB")
    pg_user = os.getenv("PG_USER")
    pg_password = os.getenv("PG_PASSWORD")

    if not all([bq_dataset, bq_table, pg_host, pg_db, pg_user, pg_password]):
        raise Exception("Missing one or more required environment variables")

    client = bigquery.Client()

    conn = psycopg2.connect(
        host=pg_host,
        port=pg_port,
        dbname=pg_db,
        user=pg_user,
        password=pg_password
    )

    cursor = conn.cursor()
    cursor.execute("SELECT * FROM your_table")  # Change this to your actual table or query
    rows = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]

    bq_rows = [dict(zip(colnames, row)) for row in rows]

    table_ref = client.dataset(bq_dataset).table(bq_table)
    errors = client.insert_rows_json(table_ref, bq_rows)

    if errors:
        print("Encountered errors while inserting rows: {}".format(errors))
    else:
        print("Inserted {} rows into {}.{}".format(len(bq_rows), bq_dataset, bq_table))

    cursor.close()
    conn.close()