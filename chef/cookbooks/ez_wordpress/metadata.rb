name 'ez_wordpress'
maintainer 'Joaquin Menchaca'
maintainer_email 'you@example.com'
license 'MIT'
description 'Installs/Configures ez_wordpress'
long_description 'Installs/Configures ez_wordpress'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)
supports 'ubuntu', '= 16.04'

depends 'ez_apache', '~> 0.1.0'
