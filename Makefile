prefix = /usr/share/modulefiles
OSNAME := $(shell cat /etc/os-release | grep ^ID=| cut -d "=" -f 2)
$(info Detected OS: $(OSNAME))

nothing:
	@echo "deb or rpm"

deb:
	@echo building deb
	@debuild


rpm: # build rpm
	@rpmbuild --define '_topdir /root/my-modules/rpmbuild' -bb rpmbuild/SPECS/my-modules.spec


install: 
	@echo installing
	install -d $(DESTDIR)$(prefix)

.PHONY: nothing
