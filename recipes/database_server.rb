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
# Create an Apache Cloudstack database server
# 1. Install MySQL server.
# 2. Initialize cloud database.


# Wrapper recipe to create the database server.
#########
#node.set['mysql']['server_root_password'] = 'cloud'
#node.set['mysql']['allow_remote_root'] = true
#node.set['mysql']['data_dir'] = '/data/mysql'

include_recipe 'mysql::server'

include_recipe 'cloudstack::mysql_conf'

