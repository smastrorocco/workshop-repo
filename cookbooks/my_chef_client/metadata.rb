name 'my_chef_client'
maintainer 'Steve Mastrorocco'
maintainer_email 'stephen.mastrorocco@gmail.com'
license 'All Rights Reserved'
description 'Configures chef-client'
long_description 'Configures chef-client'
version '1.0.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

issues_url 'https://github.com/smastrorocco/workshop-repo/issues'
source_url 'https://github.com/smastrorocco/workshop-repo'

supports 'centos'

depends 'chef-client', '~> 10.0.5'
