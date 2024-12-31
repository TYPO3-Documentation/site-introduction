.PHONY: help
help: ## Displays this list of targets with descriptions
	@echo "The following commands are available:\n"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: update-sitepackage
update-sitepackage: ## Update the site package
	./Build/DownloadSitePackage/generate_sitepackage.sh

.PHONY: update-composer
update-composer: ## Update the site package
	ddev composer install

.PHONY: setup
setup:
	ddev typo3 setup --force  --create-site '' --password 'db'
	ddev typo3 extension:setup

.PHONY: update
update: update-sitepackage update-composer ## Update everything

.PHONY: install
install: update restart setup ## Install everything

.PHONY: restart
restart: ## Restart DDEV
	@echo "Restarting DDEV to ensure it can detect TYPO3 version and create additional.php"
	ddev restart

.PHONY: delete
delete: ## Delete DDEV and Database
	ddev delete  --omit-snapshot
	rm -rf vendor
	rm -rf var
	rm -rf public
	rm config/system/additional.php

.PHONY: delete-db
delete-db: ## Delete DDEV and Database
	ddev exec -s db 'mysql --database=mysql -e "DROP DATABASE db; CREATE DATABASE db;"'
