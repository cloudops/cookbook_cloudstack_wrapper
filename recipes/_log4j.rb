# Cookbook Name:: cloudstack_wrapper
# Resource:: _log4j
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

service 'rsyslog' do
  action :nothing
end

file '/etc/rsyslog.d/30-cloudstack.conf' do
    action :delete
end

cookbook_file '/etc/rsyslog.conf' do
  source "#{node['cloudstack']['release_major']}/rsyslog.conf"
  owner 'root'
  group 'root'
  notifies :restart, 'service[rsyslog]'
end

cookbook_file '/etc/cloudstack/management/log4j-cloud.xml' do
  source "#{node['cloudstack']['release_major']}/log4j-cloud.xml"
  owner 'root'
  group 'root'
end

cron 'cloudstack_log_cleanup' do
  minute '0'
  hour '1'
  user 'root'
  command 'find /var/log/cloudstack/management/ -mtime +3 -delete'
end