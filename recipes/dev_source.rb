#
# Cookbook Name:: cloudstack_wrapper
# Recipe:: dev_source
# Author:: Pierre-Luc Dion (<pdion@cloudops.com>)
# Copyright:: Copyright (c) 2015 CloudOps.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
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
# Install and build CloudStack from Source

# dependencies
#include_recipe 'build-essential::default'
#include_recipe 'java'
#include_recipe 'git'
#include_recipe 'maven'
#include_recipe 'tomcat'

service 'tomcat6' do
	action :stop, :disable
end

include_recipe 'cloudstack_wrapper::nfsshares'
include_recipe 'cloudstack_wrapper::database_server'

package 'python-setuptools'
package 'python-pip'

git "/data/cloudstack_source" do
   repository node['cloudstack']['source']['repo']
   revision node['cloudstack']['source']['branch']
   checkout_branch node['cloudstack']['source']['branch']
   action :sync
   user "root"
   group "root"
end

# download initial systemvm template
cloudstack_system_template 'xenserver' do
  nfs_path    node['cloudstack']['secondary']['path']
  nfs_server  node['cloudstack']['secondary']['host']
  url         node['cloudstack']['systemvm']['xenserver']
  db_user     node['cloudstack']['db']['username']
  db_password node['cloudstack']['db']['password']
  db_host     node['cloudstack']['db']['host']
  action :create
end
