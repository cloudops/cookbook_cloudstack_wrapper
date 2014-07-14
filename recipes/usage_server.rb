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
# Create an Apache Cloudstack usage service

include_recipe "cloudstack::usage"


# search in the environment if cloudstack-usage is already running. if not enable one.
host_with_usage = search(:node, "chef_environment:#{node.chef_environment} AND tags:cloudstack-usage")
if host_with_usage.nil? or ( host_with_usage.count == 0 or host_with_usage[0].name == node.name )
  
  service "cloudstack-usage" do
    supports :restart => true, :status => true, :start => true, :stop => true
    action [ :enable, :start ]
  end
  
  ruby_block "tag_usage" do
    block do
      node.tags << "cloudstack-usage"
      node.save
    end
    not_if { node.tags.include?("cloudstack-usage") }
    #action :create
  end
  
else
  service "cloudstack-usage" do
    supports :restart => true, :status => true, :start => true, :stop => true
    action [ :disable, :stop ]
  end  
end