# LISA18: Test Driven Infrastructure

## Introduction

Test Driven Infrastructure (_Compliance as Code_) is the process to design the infrastructure through tests.  

The idea is that you would first experiment, model, and build out your infrastructure, and then build tests to certify that infrastructure works as designed. With this baseline, you can then create an infrastructure from nothing.

## Topics

In this material, we will build web-database services in two change configuration systems: Chef and Ansible, and then use InSpec to verify that these were created as desired.  We will turn three categories of tests:

* **Contract Tests (Promise)** - can the service respond as expected
* **Conformance Test** - a platform should meet the needs to host the application, e.g. apache modules required, mysql databases created, etc.
* **Security Tests** - follow best practices to secure the application

## Slide Deck 

* https://slides.com/devopsstudio/lisa18_tdi

## Implementation

Tools Used:
 * [InSpec](https://www.inspec.io/) - infrastructure compliance test tool
 * [Test Kitchen](https://kitchen.ci/) - test harness to converge and verify results
 * [Chef](https://www.chef.io/chef/) - change configuration management that uses agents apply desired state
 * [Ansible](https://www.ansible.com/) - remote execution tool that does change configuration, infrastructure as code, and device configuration.

## Guest Test Environments

These scripts require Linux guests to run, and so you need either virtualization solution or [Docker](https://www.docker.com/).  Test Kitchen by default uses [Vagrant](https://www.vagrantup.com/) to manage virtual machines, such as [Virualbox](https://www.virtualbox.org/) or [Hyper-V](https://en.wikipedia.org/wiki/Hyper-V).  

I recommend using [Docker](https://www.docker.com/) as it is faster than running full virtual machines, and more suitable for CI solution like [Jenkins](https://jenkins.io/).  

Note that in this scenario, [Docker](https://www.docker.com/) is used as _virtual_ virtual machines, not the common application usage, where one process stands up the container.  Care has been taking to make sure the change configuration scripts and compliance test scripts detect and adjust for full virtual machine or a restricted container environment.

## Host Worksation Setup

The shortest path to get minimal needed is [Docker](https://www.docker.com/) and [ChefDK](https://downloads.chef.io/chefdk/). Once [ChefDK](https://downloads.chef.io/chefdk/) is installed, you will need to install kitchen-ansible plug-in for [Ansible](https://www.ansible.com/) support: `chef gem install kitchen-ansible`.

Alternatively, I have created a small `Vagrantfile`, which can work to bring up a workstation suitable for running these tests.

### Virtual Host Workstation Instructions

The host system will have to have  [Virualbox](https://www.virtualbox.org/) installed or [Hyper-V](https://en.wikipedia.org/wiki/Hyper-V).

```bash
vagrant up
vagrant ssh
```

Note that this can take some time to download the Ubuntu 16.04 image initially.

#### Installing Directly on Mac OS X

If you have [HomeBrew](https://brew.sh/) installed, you can get the components using:

```bash
brew cask install docker
brew tap chef/chef
brew cask install chefdk
chef gem install kitchen-ansible
```

#### Installing Directly on Windows

The Chef parts of this 
If you have [Chocolatey](https://chocolatey.org/), you can get the components running:

```bash
choco insdtall docker-for-windows
choco install chefdk
refreshenv
chef gem install kitchen-ansible
```

#### Installing Directly on Linux

Both Debian and RHEL family of distros will work.  Other Linux solutions can work, but the process is more complex.

This is how you can get this installed on Ubuntu 16.04.

```bash
  ##### Add Docker Repo
  DOCKER_REPO="https://download.docker.com/linux/ubuntu"
  curl -fsSL ${DOCKER_REPO}/gpg | apt-key add -
  add-apt-repository \
    "deb [arch=amd64] ${DOCKER_REPO} \
    $(lsb_release -cs) \
    stable"
  apt-get update -qq

  ##### Prerequisites (just in case)
  apt-get install -y \
      apt-transport-https \
      ca-certificates \
      software-properties-common

  ##### Install Docker
  apt-get install -y docker-ce

  ##### ChefDK
  VER=3.2.30
  PKG=chefdk_${VER}-1_amd64.deb
  PREFIX=https://packages.chef.io/files/stable/chefdk/${VER}
  wget --quiet ${PREFIX}/ubuntu/16.04/${PKG}
  dpkg -i ${PKG}

  ##### Kitchen-Ansible
  chef gem install kitchen-ansible
```

## Running the Tools

Once you you have the requirements installed, you can navigate to the target directory, and run the tools.

These instructions assume you are running it on the host and from the current directory of this repository.  If you are running these from the virtual workstation, then you first need to run `cd /vagrant`.

**Note**: These are instructions are for POSIX shell.

### Testing Apache2 configured by Chef

```bash
pushd chef/cookboks/ez_apache
export KITCHEN_YAML=kitchen.docker.yml
# Create test environment
kitchen create
# Fix SSH private key (just in case)
chmod 600 .kitchen/docker_id_rsa
# Configure and Test
kitchen converge 
kitchen verify
# Fix Scripts
vi recipes/default.rb
# Configure and Test
kitchen converge 
kitchen verify
# Cleanup
kitchen destroy
popd
```

### Testing MySQL configured by Chef

```bash
pushd chef/cookboks/ez_mysql
export KITCHEN_YAML=kitchen.docker.yml
# Create test environment
kitchen create
# Fix SSH private key (just in case)
chmod 600 .kitchen/docker_id_rsa
# Configure and Test
kitchen converge 
kitchen verify
# Fix Scripts
vi recipes/default.rb
# Configure and Test
kitchen converge 
kitchen verify
# Cleanup
kitchen destroy
popd
```

### Testing Apache2 configured by Ansible

```bash
pushd ansible/roles/ez_apache
export KITCHEN_YAML=kitchen.docker.yml
# Create test environment
kitchen create
# Fix SSH private key (just in case)
chmod 600 .kitchen/docker_id_rsa
# Configure and Test
kitchen converge 
kitchen verify
# Fix Scripts
vi tasks/main.yml
# Configure and Test
kitchen converge 
kitchen verify
# Cleanup
kitchen destroy
popd
```

### Testing MySQL configured by Ansible

```bash
pushd ansible/roles/ez_mysql
export KITCHEN_YAML=kitchen.docker.yml
# Create test environment
kitchen create
# Fix SSH private key (just in case)
chmod 600 .kitchen/docker_id_rsa
# Configure and Test
kitchen converge 
kitchen verify
# Fix Scripts
vi tasks/main.yml
# Configure and Test
kitchen converge 
kitchen verify
# Cleanup
kitchen destroy
popd
```