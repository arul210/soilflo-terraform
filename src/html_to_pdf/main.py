import pdfkit
from flask import Flask, request, make_response

app = Flask(__name__)

@app.route('/', methods=['POST'])
def html_to_pdf():
    html_content = request.data.decode('utf-8')
    if not html_content:
        return "No HTML content provided", 400

    try:
        pdf_bytes = pdfkit.from_string(html_content, False)
        response = make_response(pdf_bytes)
        response.headers['Content-Type'] = 'application/pdf'
        response.headers['Content-Disposition'] = 'attachment; filename=output.pdf'
        return response
    except Exception as e:
        return f"Error generating PDF: {str(e)}", 500
