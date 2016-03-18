# Cookbook Name:: cloudstack_wrapper
# Resource:: management_server
# Author:: Pierre-Luc Dion (<pdion@cloudops.com>)
#
# Copyright:: Copyright (c) 2015 CloudOps.com
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


# Install ruby-vault
chef_gem 'vault' do
      compile_time true
end

require 'vault'

# Retrieve secrets
Vault.address   = "http://104.41.138.248"
Vault.token     = "1b5d1f30-8568-fe74-335d-64f1c2d36acd"
root_password   = Vault.logical.read("secret/admin").data[:password]



who_is_my_db = search(:node, "chef_environment:#{node.chef_environment} AND recipe:mysql-server")

my_db = who_is_my_db.first

#node.set['cloudstack']['db']['host'] = my_db.ipaddress

# init database and connection configuration
cloudstack_setup_database my_db.ipaddress do
  root_user     'admin'
  root_password root_password
  user          node['cloudstack']['db']['username']
  password      node['cloudstack']['db']['password']
  action        :create
end



cloudstack_setup_management node.name

service 'cloudstack-management' do
  action [ :enable, :start ]
end

#cloudstack_generate_api_keys 'admin'
#cloudstack_api_keys 'admin' do
#  admin_apikey    node['cloudstack']['admin']['api_key']
#  admin_secretkey node['cloudstack']['admin']['secret_key']
#  action          :create
#  # adding delay to let CloudStack management-server start properly
#  retries         12
#  retry_delay     5
#end