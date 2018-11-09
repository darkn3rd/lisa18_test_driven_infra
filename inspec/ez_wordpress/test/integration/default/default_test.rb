# # encoding: utf-8

# Inspec test for recipe ez_wordpress::default

# This is an example test, replace it with your own test.
describe port(80) do
  it { should be_listening }
end

%w(php7.0
  libapache2-mod-php7.0
  php7.0-mcrypt
  php7.0-mysql
  php7.0-curl
  php7.0-gd
  php7.0-mbstring
  php7.0-xml
  php7.0-xmlrpc
).each do |package|
  describe package(package) do
    it { should be_installed }
  end
end
