#!/usr/bin/env bash
# Extracts the CHANGELOG.md section for a given release version (e.g. "3.5.2",
# no "v" prefix — that's how entries are headed in this repo's Keep a Changelog
# -style CHANGELOG.md): the category header + bullets between its "## [X.Y.Z]"
# heading and the next heading, heading itself stripped. This is exactly what
# goes into the GitHub Release body.
#
# Usage: extract_changelog_section.sh <version e.g. 3.5.2> [changelog-file]

set -euo pipefail

VERSION="${1:?usage: extract_changelog_section.sh <version e.g. 3.5.2> [changelog-file]}"
CHANGELOG="${2:-CHANGELOG.md}"

awk -v ver="$VERSION" '
  BEGIN { in_section = 0; found = 0; n = 0 }
  /^## \[[0-9]/ {
    if (in_section) { exit }
    if ($0 == "## [" ver "]") { in_section = 1; found = 1; next }
    next
  }
  in_section { n++; buf[n] = $0 }
  END {
    if (!found) { exit 1 }
    # trim trailing blank lines
    while (n > 0 && buf[n] ~ /^[[:space:]]*$/) { n-- }
    # trim leading blank lines
    start = 1
    while (start <= n && buf[start] ~ /^[[:space:]]*$/) { start++ }
    for (i = start; i <= n; i++) { print buf[i] }
  }
' "$CHANGELOG"
