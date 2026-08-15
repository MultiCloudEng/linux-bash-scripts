#!/bin/bash
name=$1

if [ -z "$name" ]; then
    echo "Error: please provide a name."
    echo "Usage: ./greet.sh <name>"
    exit 1
fi

echo "Hello , $name!"
echo "Welcome to your server."

