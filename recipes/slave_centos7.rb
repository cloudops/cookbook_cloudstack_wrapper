# Cookbook Name:: cloudstack_wrapper
# Resource:: slave_centos7
# Author:: Pierre-Luc Dion (<pdion@cloud.ca>)
#
# Copyright:: Copyright (c) 2017 cloud.ca
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.require "system_vm_template"

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
# Create an Apache Cloudstack Management server with folllowing:
#
# 1. Install CloudStack packages
# 2. Initialize MySQL database
# 3. Download systemVM template
# 4. Configure CloudStack configuration files
# 5. Start cloudstack-management
# 6. Generate API keys for admin
###############################################################################

include_recipe 'selinux::disabled'
include_recipe 'cloudstack::management_server'
#include_recipe 'cloudstack_wrapper::_log4j'
include_recipe 'cloudstack_wrapper::_filebeat'
include_recipe 'cloudstack_wrapper::eventlog'

# init database and connection configuration
cloudstack_setup_database node['cloudstack']['db']['host'] do
  user          node['cloudstack']['db']['user']
  password      node['cloudstack']['db']['password']
  action        :create
end

cloudstack_setup_management node.name do
  action :run
end

service 'cloudstack-management' do
#  action [ :enable, :start ]
  action [ :disable, :stop ]
end

package "cloudstack-usage" do
   action :install
#   only_if { node.recipes.include?('cloudstack::management_server') }
end


cron 'cloudstack_log_cleanup' do
  minute '0'
  hour '1'
  user 'root'
  command 'find /var/log/cloudstack/management/ -mtime +3 -delete'
end
