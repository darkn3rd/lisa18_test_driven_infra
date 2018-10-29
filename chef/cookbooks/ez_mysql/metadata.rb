name 'ez_mysql'
maintainer 'Joaquin Menchaca'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures ez_mysql'
long_description 'Installs/Configures ez_mysql'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'mysql2_chef_gem', '~> 2.1.0'
depends 'database', '~> 6.1.1'
