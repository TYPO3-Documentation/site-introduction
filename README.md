# DDEV Setup

To use this repository we recommend to use ddev as environment. Please download
and install DDEV https://github.com/drud/ddev/releases.

* `ddev start`
* `ddev import-db --src=./data/db.sql`
* `ddev import-files --src=./assets`

# Frontend

* TYPO3: http://introduction.ddev.local
* Mail Hogg: http://introduction.ddev.local:8025
* PHP My Admin: http://introduction.ddev.local:8036

# Credentials Backend

* URL: http://introduction.ddev.local/typo3
* Username: `admin`
* Password: `password`

# Admin Tools

* URL: http://introduction.ddev.local/typo3/install.php
* Password: `password`

# Executing Commands

If you need to execute commands like `composer` or `bin/typo3` you need to run
these commands within the ddev containers. You can easily log into the web
container by executing the command `ddev ssh`. Its also possible to run commands
within the container without the need to log into it.

* Composer Install: `ddev exec composer install -d /var/www/html`
* Database Export: `ddev exec php ../bin/typo3 ddev:exportdb`

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
TYPO3_TRUSTED_HOST_PATTERN = "introduction.ddev.local"

# Site
SITE_INTRODUCTION_BASE = "http://introduction.ddev.local/"
```
