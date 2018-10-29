# # encoding: utf-8
# Inspec test for recipe ez_mysql::default

title 'Apache server contract test'

only_if do
  command(apache.service).exist?
end

###### CONTRACT TESTING

control 'ez_apache-contract-01' do
  impact 1.0
  title 'Apache should be listening'
  desc 'Apache should be listening.'
  describe port(80) do
    it { should be_listening }
  end
end
