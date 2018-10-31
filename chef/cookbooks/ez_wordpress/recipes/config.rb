#
# Cookbook:: ez_wordpress
# Recipe:: config
#
# Copyright:: 2018, The Authors, All Rights Reserved.

template "#{node['wordpress']['dir']}/wp-config.php" do
  source 'wp-config.php.erb'
  mode '0644'
  variables(
    db_name:           node['wordpress']['db']['name'],
    db_user:           node['wordpress']['db']['user'],
    db_password:       node['wordpress']['db']['pass'],
    db_host:           node['wordpress']['db']['host'],
    auth_key:          node['wordpress']['keys']['auth'],
    secure_auth_key:   node['wordpress']['keys']['secure_auth'],
    logged_in_key:     node['wordpress']['keys']['logged_in'],
    nonce_key:         node['wordpress']['keys']['nonce'],
    auth_salt:         node['wordpress']['salt']['auth'],
    secure_auth_salt:  node['wordpress']['salt']['secure_auth'],
    logged_in_salt:    node['wordpress']['salt']['logged_in'],
    nonce_salt:        node['wordpress']['salt']['nonce'],
  )
  owner 'www-data'
  group 'www-data'
  action :create
end
