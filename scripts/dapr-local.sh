#!/bin/bash

# Directory where certificates will be stored
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
SRC_PATH=$(realpath "${SCRIPT_DIR}/../src/api")

cd ${SRC_PATH}
source .venv/bin/activate
dapr run -f ./dapr.yaml 