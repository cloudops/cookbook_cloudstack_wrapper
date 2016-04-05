# Cookbook Name:: cloudstack_wrapper
# Resource:: mgt_remotenfs
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
# Create an Apache Cloudstack Management server using remote NFS server:
# 1.  mount NFS share for Secondary Storage
# 4.  Install Cloudstack management-server
# 4.1 Initialize cloud databases
# 4.2 Download initial system vm template
# 5.  Install usage server
# 6.  apply Global settings tunings
###############################################################################

include_recipe 'nfs'

directory node['cloudstack']['secondary']['path'] do
  owner "root"
  group "root"
  action :create
  recursive true
end

mount node['cloudstack']['secondary']['path'] do
  device "#{node['cloudstack']['secondary']['host']}:#{node['cloudstack']['secondary']['path']}"
  fstype "nfs"
  options "rw"
  action [:mount]
  not_if { node['cloudstack']['secondary']['host'] == node.name or node['cloudstack']['secondary']['host'] == node["ipaddress"] or node['cloudstack']['secondary']['host'] == "localhost" }
end

include_recipe 'cloudstack_wrapper::management_server'
include_recipe 'cloudstack::usage'

# Changing Global Settings example:
#cloudstack_global_setting 'expunge.delay' do
#  admin_apikey    node['cloudstack']['admin']['api_key']
#  admin_secretkey node['cloudstack']['admin']['secret_key']
#  value '80'
#  retries 5
#  retry_delay 2
#  #notifies :restart, "service[cloudstack-management]", :delayed
#end