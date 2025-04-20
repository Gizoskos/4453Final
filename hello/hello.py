from flask import Flask
import psycopg2
import os
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
app = Flask(__name__)

KEY_VAULT_NAME = os.getenv("vault4453")
VAULT_URL = f"https://{KEY_VAULT_NAME}.vault.azure.net"

credential = DefaultAzureCredential()
client = SecretClient(vault_url=VAULT_URL, credential=credential)

db_user = client.get_secret("DbUsername").value
db_password = client.get_secret("DbPassword").value
db_name = os.getenv("DB_NAME")
db_host = os.getenv("DB_HOST")

@app.route("/hello")
def hello():
    try:
        connection = psycopg2.connect(
            host = db_host,
            dbname = db_name,
            user = db_name,
            password = db_password
        )
        cursor = connection.cursor()
        cursor.execute("SELECT version();")
        result = cursor.fetchone
        connection.close()
        return f"Connected to PostgreSQL!"
    except Exception as ex:
        return f"Db connection failed!"
    
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
