OSNAME := $(shell cat /etc/os-release | grep ^ID=| cut -d "=" -f 2)
$(info === Detected Linux distro: $(OSNAME) ===)

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

deb: releasefile ## Build deb
	@echo building deb
	@debuild

rpm: releasefile packmodules ## Build rpm
        # _pkgrel is a custom macro used by the .spec file to set the release
	@rpmbuild --define '_pkgrel $(shell cat pkg-release)' --define '_topdir /root/my-modules/rpmbuild' -bb rpmbuild/SPECS/my-modules.spec


releasefile: ## Generate the release file
	@git describe --tags --dirty --always | tr '-' '_' > pkg-release
	@echo Building version: `cat pkg-release`

install: 
	@echo installing
	@install -d $(DESTDIR)$(prefix)

clean:
	@rm pkg-release
	@rm rpmbuild/SOURCES/modules.tar.gz

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
