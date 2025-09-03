FROM python:3.11-slim

# System deps (faster builds + CA certs)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install deps first (better layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY main.py .

# Service account credentials now supplied via environment variables

# Run
CMD ["python", "main.py"]
