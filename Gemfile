source "https://rubygems.org"

gem 'chef',      '>= 14.4'
gem 'berkshelf', '~> 7.0'

group :test do
  gem 'foodcritic', '~> 14.0'
  gem 'chefspec', '~> 7.2'
  gem 'cookstyle', '~> 3.0'
end

group :integration do
  gem 'test-kitchen',    '~> 1.23'
  gem 'kitchen-vagrant', '~> 1.3'
  gem 'inspec', '~> 2.2'
  gem 'kitchen-inspec', '~> 0.23'
  gem 'kitchen-vagrant', '~> 1.3'
  gem 'kitchen-docker', '~> 2.7'
  gem 'kitchen-ansible', '~> 0.48'
end
