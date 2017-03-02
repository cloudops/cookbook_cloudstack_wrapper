# Cookbook Name:: cloudstack_wrapper
# Resource:: test_packages
# Author:: Pierre-Luc Dion (<pdion@cloudops.com>)
#
# Copyright:: Copyright (c) 2017 CloudOps.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.require
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
###############################################################################
#
# Used to test installation Apache Cloudstack packages from RC or new release.
#
# Create an Apache Cloudstack Management server with folllowing:
#
# 1. Install CloudStack packages
# 2. Initialize MySQL database
# 4. Configure CloudStack configuration files
# 5. Start cloudstack-management
# 6. Generate API keys for admin
###############################################################################


#include_recipe 'selinux::permissive'
selinux_state "SELinux Permissive" do
  action :permissive
end
bash "setenforce" do
  code "setenforce 0"
end

include_recipe 'yum-mysql-community::mysql56'

mysql_service 'default' do
  bind_address '0.0.0.0'
  port '3306'
  data_dir node['mysql']['data_dir']
  initial_root_password node['cloudstack']['db']['rootpassword']
  action [:create, :start]
end

include_recipe 'cloudstack::mysql_conf'

include_recipe 'cloudstack::management_server'
#include_recipe 'cloudstack::usage'


# init database and connection configuration
cloudstack_setup_database node['cloudstack']['db']['host'] do
  root_user     node['cloudstack']['db']['rootusername']
  root_password node['cloudstack']['db']['rootpassword']
  user          node['cloudstack']['db']['user']
  password      node['cloudstack']['db']['password']
  action        :create
end

cloudstack_setup_management node.name do
#  tomcat7 true
end

service 'cloudstack-management' do
  action [ :enable, :start ]
end
