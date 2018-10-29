Role Name
=========

EZ Apache is a simple cookbook that installs Apache server with settings required to run WordPress.

Requirements
------------

- Ubuntu 16.04

Example Playbook
----------------

    - hosts: all
      become: true
      roles:
         - ez_mysql

License
-------

MIT

Author Information
------------------

Joaquín Menchaca

Test Kitchen
============

This has been tested with Docker and Vagrant using Virtualbox or Hyper-V.  To try out the systems do the following:

Windows / Vagrant / Hyper-V
---------------------------
On Windows 10, Microsoft might install a broken version of OpenSSH that will break if you have a `$home/.ssh/config`.  Recommend disabling this feature, and use Hashicorp's embedded ssh.

```PowerShell
$env:KITCHEN_YAML = "kitchen.hyperv.yml"
kitchen create
$env:Path += ";C:\HashiCorp\Vagrant\embedded\usr\bin"
kitchen login
```

MacOS X / Vagrant / Virtualbox
-------------------------------

```bash
export KITCHEN_YAML=kitchen.vbox.yml
kitchen create
kitchen login
```

Docker
------


```bash
export KITCHEN_YAML=kitchen.docker.yml
kitchen create
chmod 600 .kitchen/docker_id_rsa
kitchen login
```

Running Test Kitchen
====================
```bash
export KITCHEN_YAML=<YOUR_ENVIRONMENT_GOES_HERE>
kitchen create
kitchen converge  # apply change config scripts
kitchen verify    # test the config
```
