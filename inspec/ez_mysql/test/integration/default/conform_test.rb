# # encoding: utf-8

# Inspec test for recipe ez_mysql::default

title 'MySQL server config conformance'


user = attribute('User', description: 'MySQL database user', default: 'root', required: true)
pass = attribute('Password', description: 'MySQL database password', default: 'iloverandompasswordsbutthiswilldo', required: true)
service_type = attribute('service_type', description: 'service type')

service_name = 'mysql'

###### CONFORMANCE TESTING

control 'ez_mysql-conform-01' do
  impact 1.0
  title 'MySQL should be running'
  desc 'MySQL should be running.'

  if service_type == 'sysv'
    describe sysv_service(service_name) do
      it { should be_installed }
      it { should be_running }
    end
  else
    describe service(service_name) do
      it { should be_installed }
      it { should be_running }
    end
  end
end

control 'ez_mysql-conform-02' do
  impact 0.5
  title 'it must have user wordpress'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where user=\"wordpress\"' | tail -1") do
    its(:stdout) { should match(/^1/) }
  end
end

control 'ez_mysql-conform-03' do
  impact 0.5
  title 'it must have database wordpress'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'show databases' | grep wordpress") do
    its(:stdout) { should match(/^wordpress/) }
  end
end
