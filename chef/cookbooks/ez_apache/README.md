# ez_apache

EZ Apache is a simple cookbook that installs Apache server with settings required to run WordPress.

# Test Kitchen

This has been tested with Docker and Vagrant using Virtualbox or Hyper-V.  To try out the systems do the following:

## Windows / Vagrant / Hyper-V

On Windows 10, Microsoft might install a broken version of OpenSSH that will break if you have a `$home/.ssh/config`.  Recommend disabling this feature, and use Hashicorp's embedded ssh.

```PowerShell
$env:KITCHEN_YAML = "kitchen.hyperv.yml"
kitchen create
$env:Path += ";C:\HashiCorp\Vagrant\embedded\usr\bin"
kitchen login
```

## MacOS X / Vagrant / Virtualbox

```bash
export KITCHEN_YAML=kitchen.vbox.yml
kitchen create
kitchen login
```

## Docker

```bash
export KITCHEN_YAML=kitchen.docker.yml
chmod 600 .kitchen/docker_id_rsa
kitchen create
kitchen login
```

# Running Test Kitchen

```bash
export KITCHEN_YAML=<YOUR_ENVIRONMENT_GOES_HERE>
export CHEF_LOG_LEVEL="auto" # optional
kitchen create
kitchen converge  # apply change config scripts
kitchen verify    # test the config
```

## Recommendations

This cookbook was a custom cookbook to illustrate how to use Chef.  I would recommend using Sious Chef's Apache2 cookbook, and maybe doing a wrapper-cookbook:

* https://github.com/sous-chefs/apache2
* https://supermarket.chef.io/cookbooks/apache2
* https://blog.chef.io/2017/02/14/writing-wrapper-cookbooks/

## References

* Optimization
  * [switch apache from prefork to event in Ubuntu 16, get php 7 working](https://serverfault.com/questions/904065/switch-apache-from-prefork-to-event-in-ubuntu-16-get-php-7-working)
  * [How to optimize Apache concurrency for running WordPress](https://checknotes.wordpress.com/2016/02/10/how-to-optimize-apache-concurrency-for-running-wordpress/)
* Apache Docs
  * [Apache MPM worker](http://httpd.apache.org/docs/current/mod/worker.html)
* Dev-Sec Hardening Scripts
  * [devops + security: Server Hardening Automation](https://dev-sec.io/)
