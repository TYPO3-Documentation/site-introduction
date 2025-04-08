#!/bin/bash

set -e

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

./Build/DownloadSitePackage/generate_sitepackage.sh

# 1. Install dependencies
composer install

# 3. Run TYPO3 setup
vendor/bin/typo3 setup --force --no-interaction

# 4. Install extensions
vendor/bin/typo3 extension:setup

# 5. Create demo users
vendor/bin/typo3 setup:begroups:default -g Both
vendor/bin/typo3 backend:user:create --username=e.doe --password=UnsaFe123! --groups=1 --email=e.doe@example.org --no-interaction
vendor/bin/typo3 backend:user:create --username=a.doe --password=UnsaFe123! --groups=1,2 --email=a.doe@example.org --no-interaction
echo "User e.doe demonstrates standard editor permissions, a.doe advanced editor permissions"

echo "Updating page permissions in SQLite..."
sqlite3 var/sqlite.db "UPDATE pages SET perms_groupid=1;"

echo "TYPO3 is ready at http://localhost:8000 (user: j.doe / UnsaFe123!)"
