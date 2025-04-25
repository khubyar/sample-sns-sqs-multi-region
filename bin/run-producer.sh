#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set isPrimary to false only if "secondary" is passed, true for "primary" or no parameter
isPrimary=$([ "$1" = "secondary" ] && echo "false" || echo "true")

# Execute the ruby script using path relative to the script location
ruby "${SCRIPT_DIR}/../src/producers/sns/producer.rb" "$isPrimary"
