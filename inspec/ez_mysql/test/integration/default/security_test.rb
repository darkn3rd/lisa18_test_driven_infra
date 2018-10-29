# # encoding: utf-8

# Inspec test for recipe ez_mysql::default

title 'MySQL server config security'

user = attribute('User', description: 'MySQL database user', default: 'root', required: true)
pass = attribute('Password', description: 'MySQL database password', default: 'iloverandompasswordsbutthiswilldo', required: true)

mysql_data_path = '/var/lib/mysql/'

###### SECURITY TESTING
control 'ez_mysql-security-conf-01' do
  impact 0.5
  title 'only one instance of mysql should run on a server'
  describe command('ps aux | grep mysqld | egrep -v "grep|mysqld_safe|logger" | wc -l') do
    its(:stdout) { should match(/^1$/) }
  end
end

# 'Mysql-config: owner, group and permissions'
control 'ez_mysql-security-conf-01' do
  describe file(mysql_data_path) do
    it { should be_directory }
    it { should be_owned_by 'mysql' }
    it { should be_grouped_into 'mysql' }
  end
end

# Parsing configfiles for unwanted entries
control 'ez_mysql-security-conf-03' do
  impact 0.7
  title 'enable secure configurations for mysql'
  describe mysql_conf.params('mysqld') do
    its('safe-user-create') { should cmp 1 }
    its('old_passwords') { should_not cmp 1 }
    its('secure-auth') { should cmp 1 }
    its('user') { should cmp 'mysql' }
    its('skip-symbolic-links') { should cmp 1 }
    its('secure-file-priv') { should_not eq nil }
    its('local-infile') { should cmp 0 }
    its('skip-show-database') { should eq '' }
    its('skip-grant-tables') { should eq nil }
    its('allow-suspicious-udfs') { should cmp 0 }
  end
end

control 'ez_mysql-security-db-01' do
  impact 1.0
  title 'deactivate annonymous user names'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where user=\"\";' | tail -1") do
    its(:stdout) { should match(/^0/) }
  end
end

control 'ez_mysql-security-db-02' do
  impact 0.5
  title 'the grant option must not be used'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where grant_priv=\"y\" and User!=\"root\" and User!=\"debian-sys-maint\";' | tail -1") do
    its(:stdout) { should match(/^0/) }
  end
end

control 'ez_mysql-security-db-03' do
  impact 0.5
  title 'ensure no wildcards are used for hostnames'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where host=\"%\"' | tail -1") do
    its(:stdout) { should match(/^0/) }
  end
end

control 'ez_mysql-security-db-04' do
  impact 0.5
  title 'it must be ensured that superuser can login via localhost only'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where user=\"root\" and host not in (\"localhost\",\"127.0.0.1\",\"::1\")' | tail -1") do
    its(:stdout) { should match(/^0/) }
  end
end
