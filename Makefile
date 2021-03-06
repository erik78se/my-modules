#
# Build packages (.deb, .rpm)
#
# RPM Namescheme [name]-[version]-[release].[arch].rpm
#
# The release number comes from the git commit hash
#
#

packmodules:
	@tar -zcvf rpmbuild/SOURCES/modules.tar.gz modules


deb: pkg-release ## Build deb
	@debuild --build=binary 


rpm: pkg-release packmodules ## Build rpm
        # _pkgrel is a custom macro used by the .spec file to set the release
	@rpmbuild --define '_pkgrel $(shell cat pkg-release | tr '-' '_')' --define '_topdir /root/my-modules/rpmbuild' -bb rpmbuild/SPECS/my-modules.spec


pkg-release: ## Generate the release file
	@git describe --tags --dirty --always > pkg-release


install: pkg-release
	@echo installing
	@install -d $(DESTDIR)$(prefix)


clean:
	@rm -f pkg-release
	@rm -f rpmbuild/SOURCES/modules.tar.gz

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
