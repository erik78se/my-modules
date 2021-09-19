#!/bin/bash
set -x
rpmbuild --define '_topdir /root/my-modules/rpmbuild' -bb rpmbuild/SPECS/my-modules.spec 
