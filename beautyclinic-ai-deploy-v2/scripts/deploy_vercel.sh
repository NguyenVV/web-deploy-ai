#!/usr/bin/env bash
set -euo pipefail
echo ">>> deploy_vercel.sh starting"
if [ -z "${VERCEL_TOKEN:-}" ]; then
  echo "VERCEL_TOKEN is not set. Exiting."
  exit 1
fi
PROJECT_NAME="${FRONTEND_PROJECT_NAME:-FKrN-beautyclinic}"
echo "Triggering Vercel deployment for project ${PROJECT_NAME} (token masked)"
echo ">>> deploy_vercel.sh finished"
