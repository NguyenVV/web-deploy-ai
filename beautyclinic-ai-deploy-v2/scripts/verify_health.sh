#!/usr/bin/env bash
set -euo pipefail
URL="$1"
TIMEOUT="${2:-60}"
echo ">>> verify_health.sh: checking $URL for up to ${TIMEOUT}s"
end=$((SECONDS + TIMEOUT))
while [ $SECONDS -lt $end ]; do
  status=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || true)
  echo "status=$status"
  if [ "$status" = "200" ]; then
    echo "health check passed for $URL"
    exit 0
  fi
  sleep 5
done
echo "health check failed for $URL"
exit 2
