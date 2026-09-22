#!/bin/bash
set -e

cd /var/www/html

# Run sitepackage generator first (must be before composer install)
echo "🔧 Downloading the generated site package from https://get.typo3.org/sitepackage ..."
./Build/DownloadSitePackage/generate_sitepackage.sh

composer install --no-interaction

# Ensure required directories exist and have correct ownership
mkdir -p var public/fileadmin public/typo3temp config/system

echo "▶ Running automated TYPO3 setup..."

./vendor/bin/typo3 setup --force \
  --driver 'sqlite' \
  --dbname '/var/www/html/var/data.sqlite' \
  --admin-username 'j.doe' \
  --admin-user-password 'Password.1' \
  --admin-email 'j.doe@example.org' \
  --create-site 'no' \
  --project-name "TYPO3 Docs Demo" \
  --server-type 'apache'

echo "✅ TYPO3 setup complete."

echo "▶ Setting up extensions..."
./vendor/bin/typo3 extension:setup

# Set correct ownership for TYPO3 runtime directories
chown -R www-data:www-data var public config

echo ""
echo "🚀 TYPO3 is up and running!"
echo "🌐 TYPO3 is running — access it via the mapped port (e.g. http://localhost:8080)"
echo ""
echo "📂 Admin Login:"
echo "   Username: j.doe"
echo "   Password: Password.1"
echo ""

# Start Apache in the foreground
exec apache2-foreground
