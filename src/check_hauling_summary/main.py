import functions_framework
import requests
import os

# Set this in your environment or secrets manager
API_URL = os.getenv("HAULING_API_URL")

@functions_framework.http
def trigger_check_hauling_summary(request):
    if request.method != 'POST':
        return 'Only POST method is allowed', 405

    try:
        response = requests.post(API_URL, timeout=10)
        response.raise_for_status()
        return f"Successfully triggered hauling summary check: {response.status_code}", 200
    except Exception as e:
        return f"Failed to trigger hauling summary check: {str(e)}", 500
