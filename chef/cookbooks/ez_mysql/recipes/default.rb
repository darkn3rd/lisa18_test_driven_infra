#
# Cookbook:: ez_mysql
# Recipe:: default
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

include_recipe 'ez_mysql::install'
include_recipe 'ez_mysql::service'
include_recipe 'ez_mysql::database'
include_recipe 'ez_mysql::harden'
