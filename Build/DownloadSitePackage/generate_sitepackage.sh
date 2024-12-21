#!/bin/bash

curl -X 'POST' \
  'https://get.typo3.org/api/v1/sitepackage/' \
  -H 'accept: application/zip' \
  -H 'Content-Type: application/json' \
  -d @"$(dirname "$0")/data.json" --output packages/my_site_package.zip

rm -rf packages/my_site_package/*
rm -rf packages/my_site_package/.*
unzip packages/my_site_package.zip -d "packages/my_site_package/"
rm packages/my_site_package.zip
