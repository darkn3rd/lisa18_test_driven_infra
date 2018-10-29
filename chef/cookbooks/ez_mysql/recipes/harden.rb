#
# Cookbook:: ez_mysql
# Recipe:: harden
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

# apply hardening configuration
template node['ez_mysql']['security-conf'] do
  owner node['ez_mysql']['user']
  mode '750'
  source 'security.cnf.erb'
  notifies :reload, "service[#{node['ez_mysql']['service']}]"
end
