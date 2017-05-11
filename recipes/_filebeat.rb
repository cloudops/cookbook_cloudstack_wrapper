# Cookbook Name:: cloudstack_wrapper
# Resource:: _filebeat
# Author:: Clément Contini (<ccontini@cloud.ca>)
#
# Copyright:: Copyright (c) 2015 CloudOps.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License

# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Add elastic repo && install filebeat
case node['platform_family']
when 'debian'
    apt_repository 'elastic' do
        uri          "https://artifacts.elastic.co/packages/5.x/apt"
        key          "https://artifacts.elastic.co/GPG-KEY-elasticsearch"
        components   ['main']
        distribution 'stable'
        deb_src      false
    end
    apt_package 'filebeat'
when 'rhel'
    yum_repository 'elastic' do
        baseurl      "https://artifacts.elastic.co/packages/5.x/yum"
        gpgkey       "https://artifacts.elastic.co/GPG-KEY-elasticsearch"
    end
    yum_package 'filebeat'
end

facility = ""

case node['ipaddress'].slice(0,7)
    when "172.25."
        facility = "log-c7.cloudops.net"
    when "172.27."
        facility = "log.system.cloud.ca"
    when "172.29."
        facility = "log-c7.cloudops.net"
    else
        facility = "loglab.cloudops.net"
end

template '/etc/filebeat/filebeat.yml' do
    source 'filebeat.yml.erb'
    mode '0755'
    owner 'root'
    group 'root'
    variables({
        facility: "#{facility}:5515"
    })
end

# Start service
service 'filebeat' do
    action [:enable, :start]
end
