# NAME: Vagrantfile
# AUTHOR: Joaquin Menchaca
# UPDATED: 2018-10-30
#
# PURPOSE: Single Machine Demo
# DEPENDENCIES:
#  * VirtualBox, Vagrant
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

############### INLINE SCRIPT
@setup_script = <<SCRIPT
  ##### Add Docker Repo
  DOCKER_REPO="https://download.docker.com/linux/ubuntu"
  curl -fsSL ${DOCKER_REPO}/gpg | apt-key add -
  add-apt-repository \
    "deb [arch=amd64] ${DOCKER_REPO} \
    $(lsb_release -cs) \
    stable"
  apt-get update -qq

  ##### Prerequisites (just in case)
  apt-get install -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      software-properties-common

  ##### Install Docker
  apt-get install -y docker-ce
  usermod -aG docker 'vagrant'
  
  ##### ChefDK
  VER=3.2.30
  PKG=chefdk_${VER}-1_amd64.deb
  PREFIX=https://packages.chef.io/files/stable/chefdk/${VER}
  wget --quiet ${PREFIX}/ubuntu/16.04/${PKG}
  dpkg -i ${PKG}

  ##### Kitchen-Ansible (vagrant context)
  su - vagrant -c 'chef gem install kitchen-ansible'
  su - vagrant -c 'chef gem install kitchen-docker'
  su - vagrant -c 'git clone https://github.com/darkn3rd/lisa18_test_driven_infra.git'
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.provider "hyperv"
  config.vm.provider "virtualbox"
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.hostname = "workstation.dev"
  config.vm.provision "shell", inline: @setup_script
end
