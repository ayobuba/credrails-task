#!/bin/bash

set -e

export DATABASE_URL="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@credrails-1.c3rq3bzfdudl.eu-central-1.rds.amazonaws.com:5432/${POSTGRES_DB}"
# Run database migrations
flask db upgrade

# Run the command provided as arguments to this script
exec "$@"