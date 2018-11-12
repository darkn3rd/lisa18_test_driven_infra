#
# Cookbook:: ez_apache
# Recipe:: config
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

# Main Confg to support .htaccess in /var/www
cookbook_file "#{node['ez_apache']['dir']}/apache2.conf" do
  source 'apache2.conf'
  action :create
end

cookbook_file "#{node['ez_apache']['mods-available']}/mpm_event.conf" do
  source 'mpm_event.conf'
  action :create
end

%w(mpm_prefork mpm_worker).each do |mod|
  execute "Disabling Module '#{mod}'" do
    command "a2dismod #{mod}"
  end
end

%w(mpm_event rewrite).each do |mod|
  execute "Enabling Module '#{mod}'" do
    command "a2enmod #{mod}"
  end
end
