#!/usr/bin/env bash
set -euo pipefail
STATUS="$1"
BACKEND_URL="$2"
FRONTEND_URL="$3"
cat <<EOF
{ "status": "${STATUS}", "backend": "${BACKEND_URL}", "frontend": "${FRONTEND_URL}" }
EOF
