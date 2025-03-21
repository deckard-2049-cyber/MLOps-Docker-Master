# Use an official lightweight Python image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    FLASK_APP=app.py \
    FLASK_RUN_HOST=0.0.0.0 \
    FLASK_ENV=production

# Create a non-root user for security
RUN groupadd -r flask && useradd -r -g flask flask

# Set working directory
WORKDIR /app

# Copy application files
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Expose the application port
EXPOSE 5000

# Health check to ensure container is running
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost:5000 || exit 1

# Change user to avoid running as root
USER flask

# Command to run the Flask application
CMD ["flask", "run", "--host=0.0.0.0"]
