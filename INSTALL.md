# Installation Guide

## Installing Directly on Mac OS X

If you have [HomeBrew](https://brew.sh/) installed, you can get the components using:

```bash
brew cask install docker
brew tap chef/chef
brew cask install chefdk

# Local ChefDK Ruby Gems
chef gem install kitchen-ansible
chef gem install kitchen-docker

# Get the project
cd
git clone https://github.com/darkn3rd/lisa18_test_driven_infra
cd lisa18_test_driven_infra
```

## Installing Directly on Windows

The Chef parts of this
If you have [Chocolatey](https://chocolatey.org/), you can get the components running:

```PowerShell
choco install docker-for-windows
choco install chefdk
refreshenv

# ChefDK Ruby Gems
chef gem install kitchen-ansible
chef gem install kitchen-docker

# Get the Project
cd $home
git clone https://github.com/darkn3rd/lisa18_test_driven_infra
cd lisa18_test_driven_infra
```

## Installing Directly on Linux

Both Debian and RHEL family of distros will work.  Other Linux solutions can work, but the process is more complex.

This is how you can get this installed on Ubuntu 16.04.

```bash
##### Add Docker Repo
DOCKER_REPO="https://download.docker.com/linux/ubuntu"
curl -fsSL ${DOCKER_REPO}/gpg | sudo apt-key add -
sudo add-apt-repository \
  "deb [arch=amd64] ${DOCKER_REPO} \
  $(lsb_release -cs) \
  stable"
sudo apt-get update -qq

##### Prerequisites (just in case)
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common

##### Install Docker
sudo apt-get install -y docker-ce
sudo usermod -aG docker $USER

##### ChefDK
VER=3.2.30
PKG=chefdk_${VER}-1_amd64.deb
PREFIX=https://packages.chef.io/files/stable/chefdk/${VER}
wget --quiet ${PREFIX}/ubuntu/16.04/${PKG}
sudo dpkg -i ${PKG}

# Local ChefDK Ruby Gems
chef gem install kitchen-ansible
chef gem install kitchen-docker

# Get the project
cd
git clone https://github.com/darkn3rd/lisa18_test_driven_infra
cd lisa18_test_driven_infra
```
