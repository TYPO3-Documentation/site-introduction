![Build Status](https://github.com/TYPO3-Documentation/site-introduction/actions/workflows/tests.yml/badge.svg)


# DDEV Setup

To use this repository we recommend to use ddev as environment. Please download
and install DDEV https://github.com/drud/ddev/releases.

[LINUX] Change permissions of ./var to 0777 (`chmod 0777 ./var/cache`) on host

* `ddev start`
* `ddev import-db --src=./data/db.sql`
* `ddev import-files --src=./assets`
* `ddev composer install`

# TYPO3 Version

The development of this installation started with TYPO3 v9.  
There exists a branch `task/v10-0` with TYPO3 v10, currently there is no guarantee
that this is running well though.  
Future branches will include a version number that indicates the TYPO3 version.

# Frontend

* TYPO3: https://introduction.ddev.site
* Mail Hogg: http://introduction.ddev.site:8025
* PHP My Admin: http://introduction.ddev.site:8036

# Credentials Backend

* URL: https://introduction.ddev.site/typo3
* Username: `admin`
* Password: `password`

# Admin Tools

* URL: https://introduction.ddev.site/typo3/install.php
* Password: `password`

# Executing Commands

If you need to execute commands like `composer` or `bin/typo3` you need to run
these commands within the ddev containers. You can easily log into the web
container by executing the command `ddev ssh`. Its also possible to run commands
within the container without the need to log into it.

* Composer Install: `ddev exec composer install`
* Database Export: `ddev exec php bin/typo3 ddev:exportdb`

# Execute acceptance tests

To execute acceptance tests the selenium service has to be enabled before starting DDEV.
This can be done by renaming the file `.ddev/docker-compose.chrome.yaml.inactive`
to `.ddev/docker-compose.chrome.yaml`.  
Consideration for deactivating the service by default has been that other tests run
significantly faster when this service is deactivated.

The ddev setup comes with a selenium-chrome container, codeception and some
acceptance tests ready to run.

* Run tests: ddev exec bin/codecept run acceptance -d -c Tests/codeception.yml

# Environment Variables

This setup is preconfigured to work with ddev. If you plan to use this setup
in a different context, please create a `.env` file and adapt the settings
to your system.

## .env.dist

```
# Database Credentials
TYPO3_DB_CONNECTIONS_DEFAULT_HOST = "db"
TYPO3_DB_CONNECTIONS_DEFAULT_PORT = 3306
TYPO3_DB_CONNECTIONS_DEFAULT_USER = "db"
TYPO3_DB_CONNECTIONS_DEFAULT_PASS = "db"
TYPO3_DB_CONNECTIONS_DEFAULT_NAME = "db"

# Graphics
TYPO3_GFX_PROCESSOR = "ImageMagick"
TYPO3_GFX_PROCESSOR_PATH = "/usr/bin/"
TYPO3_GFX_PROCESSOR_PATH_LZW = "/usr/bin/"

# Mail
TYPO3_MAIL_TRANSPORT = "smtp"
TYPO3_MAIL_TRANSPORT_SMTP_SERVER = "localhost:1025"

# System
TYPO3_TRUSTED_HOST_PATTERN = "introduction.ddev.site"

# Site
SITE_INTRODUCTION_BASE = "https://introduction.ddev.site/"
```
