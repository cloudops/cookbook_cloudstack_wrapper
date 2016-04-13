# Cookbook Name:: cloudstack_wrapper
# Resource:: eventlog
# Author:: Pierre-Luc Dion (<ccontini@cloudops.com>)
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

# This attribute must be set at the environement level
if node['cloudstack']['eventlog']['virtualHost'].empty? then
    Chef::Log.info('This recipe need cloudstack.eventlog.virtualHost to be defined at the environment level.')
    return
end

service 'cloudstack-management' do
  action :nothing
end

directory '/etc/cloudstack/management/META-INF/cloudstack/core' do
    owner       'root'
    group       'root'
    recursive   true
    mode        '0755'
    action      :create
end

case node['ipaddress'].split('.')[1]
    when '25', '29'
        rabbit_host = 'msg-east.cloud.ca'
    else
        rabbit_host = '172.16.1.137'
end

if not node['cloudstack']['eventlog']['server'].empty? then
    rabbit_host = node['cloudstack']['eventlog']['server']
end

template '/etc/cloudstack/management/META-INF/cloudstack/core/spring-event-bus-context.xml' do
    source 'spring-event-bus-context.xml.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables({
        :server => rabbit_host,
        :username => node['cloudstack']['eventlog']['username'],
        :password => node['cloudstack']['eventlog']['password'],
        :virtualHost => node['cloudstack']['eventlog']['virtualHost']
    })
    notifies :restart, "service[cloudstack-management]"
end
