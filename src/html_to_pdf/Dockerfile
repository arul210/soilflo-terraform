# Use official Python slim image
FROM python:3.12-slim

# Install wkhtmltopdf dependencies and wkhtmltopdf itself
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    xfonts-base \
    fontconfig \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables (modern format)
ENV PORT=8080 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1
    
# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY main.py .

# Expose port (Cloud Run listens on 8080 by default)
EXPOSE 8080

# Command to run the app with gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]