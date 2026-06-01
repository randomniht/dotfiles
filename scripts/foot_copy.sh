#!/usr/bin/env bash

TEMP_FILE=$(mktemp /tmp/foot_history.XXXXXX)

cat > "$TEMP_FILE"

cat "$TEMP_FILE" | wl-copy

rm -f "$TEMP_FILE"
