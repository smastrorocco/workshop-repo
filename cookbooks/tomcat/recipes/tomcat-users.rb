#
# Cookbook:: tomcat
# Recipe:: tomcat-users
#
# Copyright:: 2018, The Authors, All Rights Reserved.

template "#{node['tomcat']['server']['install_directory']}/conf/tomcat-users.xml" do
  owner node['tomcat']['server']['user']
  group node['tomcat']['server']['group']
  mode '0600'
  action :create
  notifies :restart, 'service[tomcat]'
end

template "#{node['tomcat']['server']['install_directory']}/webapps/manager/META-INF/context.xml" do
  source 'manager-context.xml.erb'
  owner node['tomcat']['server']['user']
  group node['tomcat']['server']['group']
  mode '0600'
  action :create
  notifies :restart, 'service[tomcat]'
end

template "#{node['tomcat']['server']['install_directory']}/webapps/host-manager/META-INF/context.xml" do
  source 'host-manager-context.xml.erb'
  owner node['tomcat']['server']['user']
  group node['tomcat']['server']['group']
  mode '0600'
  action :create
  notifies :restart, 'service[tomcat]'
end
