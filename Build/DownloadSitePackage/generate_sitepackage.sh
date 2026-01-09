#!/usr/bin/env bash
set -euo pipefail

ZIP_URL="https://github.com/TYPO3-Documentation/site_package/archive/refs/heads/update%2Fv14.zip"
ZIP_FILE="packages/site_package-update-v14.zip"
TARGET_DIR="packages/site_package"

mkdir -p packages

# download
curl -L -H 'accept: application/zip' "$ZIP_URL" --output "$ZIP_FILE"

mkdir -p "$TARGET_DIR"
rm -rf "${TARGET_DIR:?}/"*
rm -rf "${TARGET_DIR:?}"/.[!.]* "${TARGET_DIR:?}"/..?* 2>/dev/null || true

# unzip to temp and move contents into target
TMP_DIR="$(mktemp -d)"
unzip -q "$ZIP_FILE" -d "$TMP_DIR"

# GitHub zip contains a single wrapper dir, e.g. "site_package-update-v14/"
EXTRACTED_DIR="$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"

cp -a "$EXTRACTED_DIR"/. "$TARGET_DIR"/

rm -rf "$TMP_DIR"
rm -f "$ZIP_FILE"

echo "Seeded $TARGET_DIR from TYPO3-Documentation/site_package (update/v14)"
