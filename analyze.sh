#!/bin/bash
count_requests() {
     echo "Total requests:"
     cat /var/log/nginx/access.log | wc -l
}

top_ips() {
     echo " Top IPs:"
     cat /var/log/nginx/access.log | awk '{print $1}' | sort | uniq -c | sort -rn
}

count_requests
top_ips
