#!/usr/bin/env bash
set -euo pipefail
echo ">>> deploy_render.sh starting"
if [ -z "${RENDER_TOKEN:-}" ]; then
  echo "RENDER_TOKEN is not set. Exiting."
  exit 1
fi
SERVICE_NAME="${BACKEND_SERVICE_NAME:-FKrN-beautyclinic-backend}"
REPO_URL="${GITHUB_REPOSITORY:-https://github.com/<yourname>/beautyclinic}"
echo "Calling Render API to create/update service: $SERVICE_NAME (token masked)"
echo ">>> deploy_render.sh finished"
