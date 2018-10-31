#
# Cookbook:: ez_wordpress
# Recipe:: install
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

# php prerequisites suitable for most WordPress features
package %w(php7.0
  libapache2-mod-php7.0
  php7.0-mcrypt
  php7.0-mysql
  php7.0-curl
  php7.0-gd
  php7.0-mbstring
  php7.0-xml
  php7.0-xmlrpc
)

# create application directory
directory node['wordpress']['dir'] do
  action :create
  recursive true
  owner 'www-data'
  group 'www-data'
  mode  '0755'
end

# fetch/extract to application directory
tar_extract node['wordpress']['url'] do
  target_dir node['wordpress']['dir']
  creates File.join(node['wordpress']['dir'], 'index.php')
  user 'www-data'
  group 'www-data'
  tar_flags [ '--strip-components 1' ]
  not_if { ::File.exists?("#{node['wordpress']['dir']}/index.php") }
end





# touch /tmp/wordpress/.htaccess
# chmod 660 wordpress/.htaccess
# cp wordpress/wp-config-sample.php wordpress/wp-config.php
# mkdir wordpress/wp-content/upgrade
# cp -a wordpress/. /var/www.html
