.PHONY: help
help: ## Displays this list of targets with descriptions
	@echo "!!!Do not use these commands in real world projects!!! The following commands are available:\n"
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

.PHONY: create-editors
create-editors:
	ddev typo3 setup:begroups:default -g Both
	ddev typo3 backend:user:create --username=e.doe --password=UnsaFe123! --groups=1 --email=e.doe@example.org --no-interaction
	ddev typo3 backend:user:create --username=a.doe --password=UnsaFe123! --groups="1,2" --email=a.doe@example.org --no-interaction
	@echo "User e.doe demonstrates standard editor permissions, a.doe advanced editor permissions"

.PHONY: update-page-permissions
update-page-permissions:
	ddev exec -s db 'mysql --database=mysql -e "UPDATE db.pages set perms_groupid=1"'

.PHONY: update
update: update-sitepackage update-composer update-page-permissions ## Update everything

.PHONY: install
install: update restart setup create-editors update-page-permissions ## Install everything

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
