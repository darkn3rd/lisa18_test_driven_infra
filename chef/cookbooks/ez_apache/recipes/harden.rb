#
# Cookbook:: ez_apache
# Recipe:: harden
#
# Copyright:: 2018, Joaquin Menchaca, All Rights Reserved.

directory node['ez_apache']['dir'] do
  mode '0751'
end

file "#{node['ez_apache']['dir']}/apache2.conf" do
  mode '0640'
end

ruby_block 'search_file_replace' do
  block do
    file = Chef::Util::FileEdit.new("#{node['ez_apache']['conf-enabled']}/security.conf")
    file.search_file_replace_line(/^ServerTokens .*$/, 'ServerTokens Prod')
    file.write_file
  end
end
