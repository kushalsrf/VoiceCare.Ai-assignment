import os
from pymongo import MongoClient
import psycopg2

mongo_client = MongoClient(os.getenv("MONGO_URI"))

postgres_conn = psycopg2.connect(
    os.getenv("POSTGRES_URI"),
    connect_timeout=5
)
