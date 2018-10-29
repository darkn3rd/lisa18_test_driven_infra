#
# Cookbook:: ez_mysql
# Recipe:: install
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

# Debian Conf Values
pkg = node['ez_mysql']['package']
val = node['ez_mysql']['database']['root_password']
type = 'password'

%w(root_password root_password_again).each do |question|
  execute "Set DebConf Question for MySQL question:'#{pkg}/#{question}'" do
    command "echo '#{pkg} #{pkg}/#{question} #{type} #{val}' | debconf-set-selections"
    not_if "dpkg-query -l #{node['ez_mysql']['package']}"
  end
end

# Install Package
package pkg do
  action :install
  not_if "dpkg-query -l #{node['ez_mysql']['package']}"
end
