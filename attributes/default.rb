# Cookbook Name:: cloudstack_wrapper
# Attribute:: default
#
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

# Database configurations
default['cloudstack']['db']['host'] = '127.0.0.1'
default['cloudstack']['db']['user'] = 'cloud'
default['cloudstack']['db']['password'] = 'password'
default['cloudstack']['db']['rootusername'] = 'root'
default['cloudstack']['db']['rootpassword'] = 'cloud'
default['cloudstack']['db']['management_server_key'] = 'password'
default['cloudstack']['db']['database_key'] = 'password'

# Default Secondary storage where system template VMs are copied.
default['cloudstack']['secondary']['host'] = node['ipaddress']
default['cloudstack']['secondary']['path'] = '/data/secondary'
default['cloudstack']['secondary']['mgt_path'] = node['cloudstack']['secondary']['path']
# Used in lab env for shared primary storage.
default['cloudstack']['primary']['host'] = node['ipaddress']
default['cloudstack']['primary']['path'] = '/data/primary'
default['cloudstack']['primary']['mgt_path'] = node['cloudstack']['primary']['path']

# subnet use to restrict NFS access to the secondary storage served from the Management server
# default['cloudstack']['network']['system']['subnet'] = '172.16.22.0/24'
default['cloudstack']['network']['system']['subnet'] = '*'

default['cloudstack']['admin']['api_key'] = '' # automatically generated
default['cloudstack']['admin']['secret_key'] = ''  # automatically generated

default['cloudstack']['eventlog']['server'] = ''
default['cloudstack']['eventlog']['username'] = 'cloudstack-events'
default['cloudstack']['eventlog']['password'] = 'cloudstack-events'
default['cloudstack']['eventlog']['virtualHost'] = '' # Override at the environment level
