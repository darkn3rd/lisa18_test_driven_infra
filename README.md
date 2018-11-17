# **LISA18: Test Driven Infrastructure**

## **Introduction**

Test Driven Infrastructure (_Compliance as Code_) is the process to design the infrastructure through tests.  

The idea is that you would first experiment, model, and build out your infrastructure, and then build tests to certify that infrastructure works as designed. With this baseline, you can then create an infrastructure from nothing.

## **Topics**

In this material, we will build web-database services in two change configuration systems: Chef and Ansible, and then use InSpec to verify that these were created as desired.  We will turn three categories of tests:

* **Contract Tests (Promise)** - can the service respond as expected
* **Conformance Test** - a platform should meet the needs to host the application, e.g. apache modules required, mysql databases created, etc.
* **Security Tests** - follow best practices to secure the application

## **Slide Deck**

* https://slides.com/devopsstudio/lisa18_tdi

## **Implementation Overview**

Tools Used:
 * [InSpec](https://www.inspec.io/) - infrastructure compliance test tool
 * [Test Kitchen](https://kitchen.ci/) - test harness to converge and verify results
 * [Chef](https://www.chef.io/chef/) - change configuration management that uses agents apply desired state
 * [Ansible](https://www.ansible.com/) - remote execution tool that does change configuration, infrastructure as code, and device configuration.

## **About Test Environments**

These scripts are written explicitly for Ubuntu 16.04, so you will need either virtualization or [Docker](https://www.docker.com/).   Test Kitchen by default uses [Vagrant](https://www.vagrantup.com/) to manage virtual machines, such as [Virualbox](https://www.virtualbox.org/) or [Hyper-V](https://en.wikipedia.org/wiki/Hyper-V).  

I recommend using [Docker](https://www.docker.com/) as it is faster than running full virtual machines, and more suitable for CI solution like [Jenkins](https://jenkins.io/).

In this scenario, [Docker](https://www.docker.com/) is used as _virtual_ virtual machines, not the common application usage, where one process stands up the container.  These scripts should work in either environment, and workaround common gotchas.


## **Setup: Easy Way - Vagrant**

An easy way to run this is with a self-contained environment using  [Vagrant](http://vagrantup.com/).

This setup will use [Virualbox](https://www.virtualbox.org/), or [Hyper-V](https://en.wikipedia.org/wiki/Hyper-V) on Windows.  

When running this the first time, it will take time to first download Ubuntu 16.04 vagrant box, and then subsequently install Docker and ChefDK. With Hyper-V, you'll be prompted to supply credentials, select virtual switch, etc.

### **Steps**

```bash
vagrant up
vagrant ssh
cd lisa18_test_driven_infra
```

### **Advanced: Alternative Providers**

If you elect to use an alternative Vagrant provider than the default configured, you can set the environment variable `VBOX_PROVIDER`.  These are not tested behaviors, so you may have to modify `Vagrantfile` with any provider specific adapations required.

```shell
# Windows PowerShell - use virtualbox
$env:VBOX_PROVIDER = "virtualbox"
# Linux - use libvrt
export VBOX_PROVIDER="libvirt"

# bring environment up
vagrant up
vagrant ssh
cd lisa18_test_driven_infra
```

## **Setup: Hard Way**

You can install the required tools the host on Windows, Linux, or macOS.  On Windows, the Ansible parts will not work for unknown reason.

You will need to install the following:

* **Virtualization Solution** (choose one or both):
    * [Vagrant](https://www.vagrantup.com/)
      * [Virualbox](https://www.virtualbox.org/)
      * [Hyper-V](https://en.wikipedia.org/wiki/Hyper-V) (bundled with Windows 10)
    * [Docker](https://www.docker.com/)
* [ChefDK](https://downloads.chef.io/chefdk/) bundles several tools:
    * [InSpec](https://www.inspec.io/) - infrastructure compliance test tool
    * [Test Kitchen](https://kitchen.ci/) - test harness to converge and verify results
        * `kitchen-ansible` plug-in
        * `kitchen-docker` plug-in
    * [Chef](https://www.chef.io/chef/) - change configuration management that uses agents apply desired state

Installation Guides (Win, Mac, Linux):
  * [INSTALL.md](INSTALL.md)    

## **Running the Tools**

Once you you have the requirements installed, you can navigate to the target directory, and run the tools.

These instructions assume you are running it on the host and from the current directory of this repository.  If you are running these from the virtual workstation, then you first need to run `cd /vagrant`.

**Note**: These are instructions are for POSIX shell.

### **Testing Apache2 configured by Chef**

```bash
pushd chef/cookbooks/ez_apache
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

### **Testing MySQL configured by Chef**

```bash
pushd chef/cookbooks/ez_mysql
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

### **Testing Apache2 configured by Ansible**

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

### **Testing MySQL configured by Ansible**

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
