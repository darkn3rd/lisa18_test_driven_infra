# # encoding: utf-8
# Inspec test for recipe ez_mysql::default

title 'Apache server config security'

only_if do
  command(apache.service).exist?
end

# ###### SECURITY TESTING
control 'ez_apache-security-01' do
  impact 1.0
  title 'User and group should be set properly'
  desc 'For security reasons it is recommended to run Apache in its own non-privileged account.'

  describe apache_conf do
    its('User') { should eq ['${APACHE_RUN_USER}'] }
    its('Group') { should eq ['${APACHE_RUN_GROUP}'] }
  end

  describe file('/etc/apache2/envvars') do
    its('content') { should match 'export APACHE_RUN_USER=www-data' }
    its('content') { should match 'export APACHE_RUN_GROUP=www-data' }
  end
end

control 'ez_apache-security-02' do
  impact 1.0
  title 'Check Apache config folder owner, group and permissions.'
  desc 'The Apache config folder should owned and grouped by root, be writable, readable and executable by owner. It should be readable, executable by group and not readable, not writeable by others.'
  describe file(apache.conf_dir) do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by('owner') }
    it { should be_writable.by('owner') }
    it { should be_executable.by('owner') }
    it { should be_readable.by('group') }
    it { should_not be_writable.by('group') }
    it { should be_executable.by('group') }
    it { should_not be_readable.by('others') }
    it { should_not be_writable.by('others') }
    it { should be_executable.by('others') }
  end
end

control 'ez_apache-security-03' do
  impact 1.0
  title 'Check Apache config file owner, group and permissions.'
  desc 'The Apache config file should owned and grouped by root, only be writable and readable by owner and not write- and readable by others.'
  describe file(apache.conf_path) do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by('owner') }
    it { should be_writable.by('owner') }
    it { should_not be_executable.by('owner') }
    it { should be_readable.by('group') }
    it { should_not be_writable.by('group') }
    it { should_not be_executable.by('group') }
    it { should_not be_readable.by('others') }
    it { should_not be_writable.by('others') }
    it { should_not be_executable.by('others') }
  end
end

control 'ez_apache-security-04' do
  impact 1.0
  title 'Set the apache server token'
  desc '\'ServerTokens Prod\' tells Apache to return only Apache as product in the server response header on the every page request'

  describe file(File.join(apache.conf_dir, '/conf-enabled/security.conf')) do
    its('content') { should match(/^ServerTokens Prod/) }
  end
end

# control 'ez_apache-security-05' do
#   impact 1.0
#   title 'Disable TRACE-methods'
#   desc 'The web server doesn’t allow TRACE request and help in blocking Cross Site Tracing attack.'

#   describe file(File.join(apache.conf_dir, '/conf-enabled/security.conf')) do
#     its('content') { should match(/^\s*?TraceEnable\s+?Off/) }
#   end
# end

# control 'ez_apache-security-06' do
#   impact 1.0
#   title 'Should not load certain modules'
#   desc 'Apache HTTP should not load legacy modules'

#   module_path = File.join(apache.conf_dir, '/mods-enabled/')
#   loaded_modules = command('ls ' << module_path).stdout.split.keep_if { |file_name| /.load/.match(file_name) }

#   loaded_modules.each do |id|
#     describe file(File.join(module_path, id)) do
#       its('content') { should_not match(/^\s*?LoadModule\s+?dav_module/) }
#       its('content') { should_not match(/^\s*?LoadModule\s+?cgid_module/) }
#       its('content') { should_not match(/^\s*?LoadModule\s+?cgi_module/) }
#       its('content') { should_not match(/^\s*?LoadModule\s+?include_module/) }
#     end
#   end
# end
