# Base Image
FROM python:3.11-slim-buster

# Run as root
USER root

RUN apt-get -q -y update && apt-get install -y gcc curl net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# Add current directory code to working directory
ADD . /app/

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@credrails-1.c3rq3bzfdudl.eu-central-1.rds.amazonaws.com:5432/${POSTGRES_DB}

# Copy entrypoint.sh and make it executable
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Install pip requirements
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Switching to a non-root user
RUN adduser --disabled-password --gecos '' bookstoreuser && usermod -aG sudo bookstoreuser
USER bookstoreuser

EXPOSE 5000
# Set the entrypoint and start server
ENTRYPOINT ["/app/entrypoint.sh"]
CMD flask db upgrade && python app.py