#!/bin/bash

set -e

if [ -f .env ]; then
  set -o allexport
  source .env
  set +o allexport
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
vendor/bin/typo3 backend:user:create --username=j.doe --password=UnsaFe123! --groups=1 --admin --maintainer --email=j.doe@example.org --no-interaction
vendor/bin/typo3 backend:user:create --username=e.doe --password=UnsaFe123! --groups=1 --email=e.doe@example.org --no-interaction
vendor/bin/typo3 backend:user:create --username=a.doe --password=UnsaFe123! --groups=1,2 --email=a.doe@example.org --no-interaction
echo "User e.doe demonstrates standard editor permissions, a.doe advanced editor permissions"

echo "TYPO3 is ready at http://localhost:8000 (user: j.doe / UnsaFe123!)"
php -S 0.0.0.0:8000 -t public > /dev/null 2>&1 &
