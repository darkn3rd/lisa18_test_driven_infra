#
# Cookbook:: ez_mysql
# Recipe:: service
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

service node['ez_mysql']['service'] do
  supports status: true, restart: true, reload: true
  action %i(enable start)
  # use different start/stop if docker contianer
  provider Chef::Provider::Service::Debian if node['virtualization']['system'] == 'docker'
end
