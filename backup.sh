#!/bin/bash
folder=$1

if [ -z "$folder" ]; then
echo "Error: there is no such kind of folder ! "
echo "Usage: ./backup.sh "
exit 1
fi

if [ -d "$folder" ]; then
tar -czf "$folder.tar.gz" "$folder"
echo "File created!"

else 
echo "there is no such folder"
exit 1
fi
