# # encoding: utf-8
# Inspec test for recipe ez_mysql::default

title 'Apache server config conformance'

only_if do
  command(apache.service).exist?
end

###### CONFORMANCE TESTING
service_type = attribute('service_type', description: 'service type')

control 'ez_apache-conform-01' do
  impact 1.0
  title 'Apache should be running'
  desc 'Apache should be running.'

  if service_type == 'sysv'
    describe sysv_service(apache.service) do
      it { should be_installed }
      it { should be_running }
    end
  else
    describe service(apache.service) do
      it { should be_installed }
      it { should be_running }
    end
  end
end

control 'ez_apache-conform-02' do
  impact 1.0
  title 'Apache modules'
  desc 'Apache modules'
  describe command('apache2ctl -M') do
    its('stdout') { should match (/mpm_event_module/) }
    its('stdout') { should match (/rewrite_module/) }
    its('stdout') { should_not match (/mpm_prefork/) }
    its('stdout') { should_not match (/mpm_worker/) }
  end
end
