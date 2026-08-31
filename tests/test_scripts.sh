#!/bin/sh
# Lightweight checks for MagiskHluda packaging scripts.
# Run from the MagiskHluda repo root: sh tests/test_scripts.sh
set -eu

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

sh -n module_template/customize.sh || fail "customize.sh syntax"
sh -n module_template/service.sh || fail "service.sh syntax"

# Magisk reports x86_64; the Florida asset is florida-x64.gz.
BINARY_FILE="florida-x64.gz"
EXTRACTED="${BINARY_FILE%.gz}"
[ "$EXTRACTED" = "florida-x64" ] || fail "gzip stem should be florida-x64, got $EXTRACTED"

# identities.json port parser used by customize.sh
tmp=$(mktemp)
cat >"$tmp" <<'EOF'
{
  "control_port": 43249,
  "prgname": "otwwoyc"
}
EOF
parsed=$(sed -n 's/.*"control_port"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*/\1/p' "$tmp" | head -1)
rm -f "$tmp"
[ "$parsed" = "43249" ] || fail "control_port parse got '$parsed'"

grep -q 'cergo666/Florida' utils.cpp || fail "getRecentTag must use cergo666/Florida"
grep -q 'hzzheyang/strongR-frida-android' utils.cpp && fail "tag source still points at strongR-frida-android"

grep -q '0.0.0.0:\$port' module_template/service.sh && fail "service.sh still listens on 0.0.0.0"
grep -q '127.0.0.1' module_template/service.sh || fail "service.sh should default to 127.0.0.1"
grep -q 'florida-\$ARCH' module_template/customize.sh && fail "customize.sh still uses florida-\$ARCH after gzip"

echo "ok MagiskHluda script checks"
