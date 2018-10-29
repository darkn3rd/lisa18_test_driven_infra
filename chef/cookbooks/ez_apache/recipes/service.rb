#
# Cookbook:: ez_apache
# Recipe:: service
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

service node['ez_apache']['service'] do
  supports status: true, restart: true, reload: true
  action %i(enable start)
end
