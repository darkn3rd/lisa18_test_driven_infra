#
# Cookbook:: ez_apache
# Recipe:: default
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

include_recipe 'ez_apache::install'
# include_recipe 'ez_apache::config'
include_recipe 'ez_apache::service'
# include_recipe 'ez_apache::harden'
