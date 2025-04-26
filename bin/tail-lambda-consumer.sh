#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/config.sh"

# Set IS_PRIMARY to false only if "secondary" is passed, true for "primary" or no parameter
IS_PRIMARY=$([ "$1" = "secondary" ] && echo "false" || echo "true")

# Set IS_ACTIVE to false only if "secondary" is passed, true for "primary" or no parameter
IS_ACTIVE=$([ "$2" = "dr" ] && echo "false" || echo "true")

# Set FUNCTION_NAME based on IS_ACTIVE flag - use consumer-lambda when active, dr-consumer-lambda when inactive
FUNCTION_NAME=$([ "$IS_ACTIVE" = "true" ] && echo "SqsConsumer" || echo "DrSqsConsumer")

# Set REGION based on IS_PRIMARY flag - use primary REGION when true, secondary REGION when false
REGION=$([ "$IS_PRIMARY" = "true" ] && echo "${PRIMARY_REGION}" || echo "${SECONDARY_REGION}")

echo "Tailing ${FUNCTION_NAME} in ${REGION}..."
sam logs --stack-name "${STACK_NAME}" --region "${REGION}" "${FUNCTION_NAME}" --filter "recorded_at" --tail 
