#!/usr/bin/env bash
# Analyze an nginx access log: total requests, top client IPs, status codes,
# most requested paths.
#
# Usage: ./analyze.sh [LOG_FILE] [TOP_N]
#   LOG_FILE  default: /var/log/nginx/access.log
#   TOP_N     how many entries to show per section (default: 10)
set -Eeuo pipefail

LOG_FILE="${1:-/var/log/nginx/access.log}"
TOP_N="${2:-10}"

die() { echo "Error: $*" >&2; exit 1; }

[[ "$TOP_N" =~ ^[1-9][0-9]*$ ]] || die "TOP_N must be a positive integer, got '$TOP_N'"
[[ -f "$LOG_FILE" ]] || die "log file not found: $LOG_FILE"
[[ -r "$LOG_FILE" ]] || die "no permission to read $LOG_FILE (try sudo)"

count_requests() {
  echo "Total requests: $(wc -l < "$LOG_FILE")"
}

# Combined log format: $1 = client IP, $7 = path, $9 = status code
top_ips() {
  echo; echo "Top $TOP_N client IPs:"
  awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | awk -v n="$TOP_N" 'NR <= n'  # not head: head would close the pipe early (SIGPIPE + pipefail)
}

status_codes() {
  echo; echo "Requests by status code:"
  awk '$9 ~ /^[0-9]{3}$/ {print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn
}

top_paths() {
  echo; echo "Top $TOP_N requested paths:"
  awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | awk -v n="$TOP_N" 'NR <= n'  # not head: head would close the pipe early (SIGPIPE + pipefail)
}

count_requests
top_ips
status_codes
top_paths
