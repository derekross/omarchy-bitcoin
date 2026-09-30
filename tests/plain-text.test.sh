#!/bin/bash
set -euo pipefail

# Every QML Text item must render as plain text so remote API strings
# cannot introduce markup or inline image loads.
root=$(cd "$(dirname "$0")/.." && pwd)
status=0

for file in "$root"/*.qml; do
  missing=$(perl -0ne '
    while (/(?<![\w.])Text \{([^{}]*)\}/g) {
      my ($body, $pos) = ($1, $-[0]);
      next if $body =~ /textFormat:\s*Text\.PlainText/;
      my $line = 1 + (() = substr($_, 0, $pos) =~ /\n/g);
      print "$line\n";
    }
  ' "$file")
  if [[ -n $missing ]]; then
    for line in $missing; do
      echo "${file#"$root"/}:$line: Text item is missing textFormat: Text.PlainText" >&2
    done
    status=1
  fi
done

exit $status
