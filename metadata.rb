name             'cloudstack_wrapper'
maintainer       'CloudOps Inc.'
maintainer_email 'pdion@cloudops.com'
license          'All rights reserved'
description      'Configures and Customize Apache CloudStack using cookbook cloudstack libraries'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "mysql", "> 5.2.0"
depends "cloudstack", ">= 3.0.0"
depends "nfs", ">= 2.0.0"

supports 'centos'
supports 'redhat'
supports 'debian'
supports 'ubuntu'
supports 'fedora'
supports 'oracle'