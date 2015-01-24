# Cookbook Name:: cloudstack_wrapper
# Resource:: nfsshares
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
# provide NFS shares for CloudStack Storage
#
###############################################################################

include_recipe 'nfs::server'

# Secondary Storage
###############################################################################
directory node['cloudstack']['secondary']['path'] do
  owner "root"
  group "root"
  action :create
  recursive true
end

nfs_export node['cloudstack']['secondary']['path'] do
  network '*'
  writeable true 
  sync false
  options ['no_root_squash','no_subtree_check']
end

# Primary Storage
###############################################################################
directory node['cloudstack']['primary']['path'] do
  owner "root"
  group "root"
  action :create
  recursive true
end

nfs_export node['cloudstack']['primary']['path'] do
  network '*'
  writeable true 
  sync false
  options ['no_root_squash','no_subtree_check']
end
