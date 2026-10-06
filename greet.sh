#!/usr/bin/env bash
# Greet a user by name. Demonstrates argument handling and input validation.
# Usage: ./greet.sh NAME
set -euo pipefail

if [[ $# -ne 1 || -z "$1" ]]; then
  echo "Error: please provide exactly one name." >&2
  echo "Usage: $0 <name>" >&2
  exit 1
fi

echo "Hello, $1!"
echo "Welcome to your server."
