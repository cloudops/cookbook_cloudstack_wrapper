# Cookbook Name:: cloudstack_wrapper
# Resource:: management_server
# Author:: Pierre-Luc Dion (<pdion@cloudops.com>)
#
# Copyright:: Copyright (c) 2014 CloudOps.com
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

include_recipe "cloudstack::management_server"

# init database and connection configuration
cloudstack_setup_database node["cloudstack"]["db"]["host"] do
  root_user     node["cloudstack"]["db"]["rootusername"]
  root_password node["cloudstack"]["db"]["rootpassword"]
  user          node["cloudstack"]["db"]["username"]
  password      node["cloudstack"]["db"]["password"]
  action        :create
end

# download initial systemvm template
cloudstack_system_template 'xenserver' do
  nfs_path    node["cloudstack"]["secondary"]["path"]
  nfs_server  node["cloudstack"]["secondary"]["host"]
  db_user     node["cloudstack"]["db"]["username"]
  db_password node["cloudstack"]["db"]["password"]
  db_host     node["cloudstack"]["db"]["host"]
end

cloudstack_setup_management node['hostname']

service "cloudstack-management" do
  action [ :enable, :start ]
end

#cloudstack_generate_api_keys "admin"
cloudstack_api_keys "admin" do
  action :create
end