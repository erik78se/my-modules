# Start a LXD image with centos8

    lxc launch images:centos/8/amd64

# Setup build env for RPM
Centos: https://wiki.centos.org/HowTos/SetupRpmBuildEnvironment

## Install rpm-build
    
    yum -y install rpm-build redhat-rpm-config git 

## Install epel
https://www.cyberciti.biz/faq/how-to-enable-and-install-epel-repo-on-centos-8-x/

    yum -y install epel-release
    yum -y repolist
    yum -y install 'dnf-command(config-manager)'
    yum -y update
    dnf -y --enablerepo=powertools install lua-filesystem
    dnf -y --enablerepo=powertools install lua-posix
    dnf -y --enablerepo=powertools install Lmod

source /etc/profile.d/00-modulepath.sh
source /etc/profile.d/modules.sh

## LMOD

    Lmod: A New Environment Module System - http://lmod.readthedocs.io/en/latest/index.html#
    Lmod: modulefile examples - http://lmod.readthedocs.io/en/latest/100_modulefile_examples.html
    Lmod: dependent modules - http://lmod.readthedocs.io/en/latest/098_dependent_modules.html

## Nameing conventions
https://lmod.readthedocs.io/en/latest/055_module_names.html

### MODULEPATH

The version of Lmod being used predefines a few paths for which it will look for modulefiles that define the modules.

MODULEPATH= \
  /opt/apps/modulefiles/Linux: \
  /opt/apps/modulefiles/Core: \
  /opt/apps/lmod/lmod/modulefiles/Core

Module files ends with .lua (E.g. example-module.lua)


### Extra: Provide a set of standard modules for all users
https://lmod.readthedocs.io/en/latest/070_standard_modules.html
    
    Using the /etc/profile.d directory system described earlier to create a file called z01_StdEnv.sh


## Rpmbuild setup for centos
https://wiki.centos.org/HowTos/SetupRpmBuildEnvironment
