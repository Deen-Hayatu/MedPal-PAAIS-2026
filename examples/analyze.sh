#!/usr/bin/env bash
# Example call to the MedPal analyze endpoint. Needs an API key (MEDPAL_API_KEY).
curl -s -X POST https://medpal.ghehrhealth.com/v1/analyze \
  -H "Authorization: Bearer ${MEDPAL_API_KEY}" \
  -H "Content-Type: application/json" \
  -d @analyze_request.json
