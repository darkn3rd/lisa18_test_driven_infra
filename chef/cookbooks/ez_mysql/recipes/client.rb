#
# Cookbook:: ez_mysql
# Recipe:: client
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

package 'mysql-client'
