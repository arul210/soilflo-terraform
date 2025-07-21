from googleapiclient.discovery import build
from google.auth import default
import base64
import json
import logging

def trigger_db_backup(event, context):
    pubsub_message = json.loads(base64.b64decode(event["data"]).decode("utf-8"))

    credentials, _ = default()
    service = build("sqladmin", "v1beta4", credentials=credentials)

    try:
        request = service.backupRuns().insert(
            project=pubsub_message["project"],
            instance=pubsub_message["instance"]
        )
        response = request.execute()
        logging.info("Backup task status: %s", response)
    except Exception as e:
        logging.error("Could NOT run backup. Reason: %s", e)
        raise
