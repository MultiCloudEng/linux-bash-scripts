#!/usr/bin/env bash
# Create a timestamped, compressed backup of a directory.
#
# Usage: ./backup.sh SOURCE_DIR [DEST_DIR]
#   DEST_DIR default: current directory
# Result: DEST_DIR/<name>-YYYYmmdd-HHMMSS.tar.gz
set -Eeuo pipefail

die() { echo "Error: $*" >&2; exit 1; }
usage() { echo "Usage: $0 SOURCE_DIR [DEST_DIR]" >&2; exit 1; }

[[ $# -ge 1 && $# -le 2 ]] || usage
src="${1%/}"
dest="${2:-.}"

[[ -d "$src" ]] || die "source directory not found: $src"
[[ -d "$dest" ]] || die "destination directory not found: $dest"
[[ -w "$dest" ]] || die "destination is not writable: $dest"

archive="$dest/$(basename "$src")-$(date +%Y%m%d-%H%M%S).tar.gz"

# -C changes into the parent so the archive contains "name/..." instead of a full path.
tar -czf "$archive" -C "$(dirname "$src")" "$(basename "$src")"

# Verify the archive can be read before reporting success.
tar -tzf "$archive" > /dev/null || die "archive verification failed: $archive"
echo "Backup created: $archive ($(du -h "$archive" | cut -f1))"
