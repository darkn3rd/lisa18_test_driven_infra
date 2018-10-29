#
# Cookbook:: ez_mysql
# Recipe:: database
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

# Install the mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  action :install
end

# Create Database
mysql_database node['ez_mysql']['database']['dbname'] do
  connection(
    host: node['ez_mysql']['database']['host'],
    username: node['ez_mysql']['database']['root_username'],
    password: node['ez_mysql']['database']['root_password']
  )
  action :create
end

# Create User
mysql_database_user node['ez_mysql']['database']['admin_username'] do
  connection(
    host: node['ez_mysql']['database']['host'],
    username: node['ez_mysql']['database']['root_username'],
    password: node['ez_mysql']['database']['root_password']
  )
  password node['ez_mysql']['database']['admin_password']
  database_name node['ez_mysql']['database']['dbname']
  host node['ez_mysql']['database']['host']
  action %i(create grant)
end
