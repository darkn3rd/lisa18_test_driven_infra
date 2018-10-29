# Install Service
default['ez_mysql']['package'] = 'mysql-server'
default['ez_mysql']['service'] = 'mysql'
default['ez_mysql']['user'] = 'mysql'

# Database
default['ez_mysql']['database']['dbname'] = 'wordpress'
default['ez_mysql']['database']['host'] = '127.0.0.1'
default['ez_mysql']['database']['root_username'] = 'root'
default['ez_mysql']['database']['admin_username'] = 'wordpress'

# Bad Practice - demo only
default['ez_mysql']['database']['admin_password'] = 'wordpress'
default['ez_mysql']['database']['root_password'] = 'Ch4ng3me'

# Best Practices
default['ez_mysql']['security-conf'] = '/etc/mysql/conf.d/security.cnf'
default['ez_mysql']['security'] = {
  'chroot' => nil,
  'safe-user-create' => 1,
  'secure-auth' => 1,
  'skip-symbolic-links' => 1,
  'skip-show-database' => true,
  'local-infile' => 0,
  'allow-suspicious-udfs' => 0,
  'automatic-sp-privileges' => 0,
  'secure-file-priv' => '/tmp'
}


