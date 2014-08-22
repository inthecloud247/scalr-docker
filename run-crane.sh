#!/bin/bash

set -o errexit
set -o nounset

if [ -z "${CRANE_FILE_URL}" ]; then
  echo "ERROR: The CRANE_FILE_URL Global Variable must be provided"
  exit 1
fi

# Deploy files in here
CRANE_DIR="/opt/crane"
CRANE_FILE=$(basename "${CRANE_FILE_URL}")

# Actually do the work!
mkdir -p -- "${CRANE_DIR}"
cd -- "${CRANE_DIR}"
curl --fail --location --silent --remote-name "${CRANE_FILE_URL}"

# Finally, launch crane
crane lift --config="${CRANE_DIR}/${CRANE_FILE}"
