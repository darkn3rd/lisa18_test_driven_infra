#
# Cookbook:: ez_wordpress
# Recipe:: apache
#
# Copyright:: 2018, The Authors, All Rights Reserved.

var_www_orig = <<-VAR_WWW_ORIG
<Directory /var/www/>
\s*Options Indexes FollowSymLinks
\s*AllowOverride None
\s*Require all granted
</Directory>
VAR_WWW_ORIG

var_www_replace = <<-VAR_WWW_ORIG
<Directory /var/www/>
\tOptions Indexes FollowSymLinks
\tAllowOverride All
\tRequire all granted
</Directory>
VAR_WWW_ORIG

ruby_block "search_file_replace_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/apache2/apache2.conf")
    file.search_file_replace(var_www_orig,var_www_replace)
    file.write_file
  end
end