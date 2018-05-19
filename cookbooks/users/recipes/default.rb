#
# Cookbook:: users
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

user 'chef' do
  password 'chef'
  action :create
end

template '/etc/ssh/sshd_config' do
  owner 'root'
  group 'root'
  mode '0600'
  action :create
  notifies :restart, 'service[sshd]', :immediately
end

service 'sshd' do
  action :nothing
end
