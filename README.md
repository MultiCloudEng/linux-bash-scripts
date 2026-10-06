# Linux Bash Scripts

Bash scripts I wrote while learning Linux administration on AWS EC2: three practical tools, plus my first practice scripts kept in `basics/`.

## Tools

| Script | What it does |
|---|---|
| `analyze.sh [LOG] [N]` | nginx access-log report: total requests, top N client IPs, requests per status code, top N paths. Default log `/var/log/nginx/access.log` |
| `backup.sh SRC [DEST]` | Timestamped `.tar.gz` backup of a directory, verified after creation. Handles paths with spaces and stores relative paths in the archive |
| `greet.sh NAME` | Argument handling and input validation |

```bash
sudo ./analyze.sh                          # default nginx log, top 10
./analyze.sh /path/to/access.log 5
./backup.sh /var/www/html /home/ubuntu/backups
```

All three use `set -euo pipefail`, validate their input, print errors to stderr and exit non-zero on failure.

## Things I learned the hard way

- `sort | uniq -c` only counts repeats correctly on sorted input, because `uniq` merges *adjacent* lines.
- With `pipefail`, `... | sort | head` can make a script fail on large inputs. `head` exits early, and `sort` is killed by SIGPIPE (exit 141). I reproduced this with a 200,000-line log and use `awk 'NR <= n'` instead.
- `for f in *.txt` runs once with the literal string `*.txt` when nothing matches, unless `shopt -s nullglob` is set.

## basics/

My first scripts from week 1 (functions, loops, arguments) and notes, kept as a record of where I started.

## Tested

ShellCheck (no findings, also in GitHub Actions). Manually tested on Ubuntu 24.04 with a sample nginx log, a missing file, invalid arguments, a directory name with spaces, and a 200k-line log for the SIGPIPE case.
