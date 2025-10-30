#!/usr/bin/env bash
set -euo pipefail
echo ">>> deploy_planetscale.sh starting"
if [ -z "${PLANETSCALE_TOKEN:-}" ]; then
  echo "PLANETSCALE_TOKEN is not set. Exiting."
  exit 1
fi
echo "Would call PlanetScale API to create database 'beautyclinic' under namespace ${PROJECT_NAMESPACE} (token masked)."
echo "Then would run migrations: init-db/migrations/002_full_schema.sql"
echo "Seeding from init-db/seeds/002_seed_full_data.sql"
echo ">>> deploy_planetscale.sh finished"
