# # encoding: utf-8

# Inspec test for recipe ez_mysql::default

title 'MySQL server contract'

###### CONTRACT TESTING
control 'ez_mysql-contract-01' do
  impact 1.0
  title 'MySQL should be listening'
  desc 'MySQL should be listening.'

  describe port(3306) do
    it { should be_listening }
  end
end
