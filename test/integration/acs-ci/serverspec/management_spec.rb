require 'serverspec'

set :backend, :exec

describe package('cloudstack-management') do
  it { should be_installed }
end

describe user('cloud') do
  it { should exist }
end

describe service('cloudstack-management') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end

