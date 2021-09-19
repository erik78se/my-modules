#!/bin/bash
# set -x

source /etc/os-release

if [ "$ID" == "centos" ]; then
  rpmbuild --define '_topdir /root/my-modules/rpmbuild' -bb rpmbuild/SPECS/my-modules.spec 
fi

if [ "$ID" == "ubuntu" ]; then
  dpkg-deb --build .
fi
