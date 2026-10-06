#!/bin/bash
name=$1

if [ -z "$name" ]; then
echo "Error: please enter your name!"
echo "Usage:./check.sh "
exit 1


else
echo "Welcome $name to your place!"
fi
