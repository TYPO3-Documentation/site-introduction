#!/bin/bash

set -e

# 1. Install dependencies
composer install

# 2. Create required directories
mkdir -p var/log public/fileadmin public/typo3temp public/uploads
chmod -R 0777 var public/fileadmin public/typo3temp public/uploads

# 3. Run TYPO3 setup
vendor/bin/typo3 setup --force --database-user-name=typo3 --database-user-password=password --database-name=typo3 --use-existing-database --site-name="Gitpod Demo" --admin-user-name=admin --admin-password=admin --admin-email=admin@example.com

# 4. Install extensions
vendor/bin/typo3 extension:setup

# 5. Create demo users
vendor/bin/typo3 setup:begroups:default -g Both
vendor/bin/typo3 backend:user:create --username=e.doe --password=UnsaFe123! --groups=1 --email=e.doe@example.org --no-interaction
vendor/bin/typo3 backend:user:create --username=a.doe --password=UnsaFe123! --groups=1,2 --email=a.doe@example.org --no-interaction
echo "User e.doe demonstrates standard editor permissions, a.doe advanced editor permissions"

echo "TYPO3 is ready at http://localhost:8000 (user: admin / admin)"
