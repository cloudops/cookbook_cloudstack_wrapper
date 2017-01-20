require 'serverspec'
set :backend, :exec

describe port(3306) do
  it { should be_listening }
end

describe service('mysql-default') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/var/run/mysql-default/mysqld.sock') do
  it { should be_socket }
end