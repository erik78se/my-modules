OSNAME := $(shell cat /etc/os-release | grep ^ID=| cut -d "=" -f 2)
$(info === Detected OS: $(OSNAME) ===)

deb: ## Build deb
	@echo building deb
	@debuild


rpm: ## build rpm
	@rpmbuild --define '_topdir /root/my-modules/rpmbuild' -bb rpmbuild/SPECS/my-modules.spec


version: ## Generate version file
	@git describe --tags --dirty --always > version
	@echo Building version: `cat version`

install: 
	@echo installing
	@install -d $(DESTDIR)$(prefix)

# Display target comments in 'make help'
help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'



# SETTINGS
# Use one shell for all commands in a target recipe
.ONESHELL:
# Set default goal
.DEFAULT_GOAL := help
# Use bash shell in Make instead of sh 
SHELL := /bin/bash

.PHONY: help
