# Cookbook Name:: cloudstack_wrapper
# Resource:: all_in_one
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
# 1. Install MySQL server
# 2. Prepare Secondary Storage (not yet implemented)
# 3. Prepare Primary Storage (not yet implemented)
# 4. Install Cloudstack management-server
# 5. Install usage server
# 6. apply Global settings tunings
###############################################################################

service 'iptables' do
  action [ :disable, :stop ]
  only_if { platform?(%w{redhat centos fedora oracle}) }
end

include_recipe 'cloudstack_wrapper::nfsshares'
include_recipe 'cloudstack_wrapper::database_server'
include_recipe 'cloudstack_wrapper::management_server'
include_recipe 'cloudstack::usage'
include_recipe 'cloudstack_wrapper::_log4j'
