name             'cloudstack_wrapper'
maintainer       'Pierre-Luc Dion'
maintainer_email 'pdion@cloudops.com'
license          'All rights reserved'
description      'Configures and Customize Apache CloudStack using cookbook cloudstack libraries'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.4'


#depends "mysql", "= 6.1.3"
depends 'mysql', '~> 8.0'
depends 'yum-mysql-community'
depends "cloudstack"
depends "nfs", ">= 2.0.0"
depends "selinux"

supports 'centos'
supports 'redhat'
supports 'debian'
supports 'ubuntu'
supports 'fedora'
supports 'oracle'

provides "cloudstack_wrapper::all_in_one"
provides "cloudstack_wrapper::mgt_remotenfs"
provides "cloudstack_wrapper::management_server"
provides "cloudstack_wrapper::database_server"
provides "cloudstack_wrapper::nfs_server"
