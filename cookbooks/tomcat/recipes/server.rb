#
# Cookbook:: tomcat
# Recipe:: server
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install OpenJDK
package node['tomcat']['server']['openjdk']['package'] do
  action :install
end

# Create Tomcat group/user
group node['tomcat']['server']['group'] do
  append true
  action :create
end

user node['tomcat']['server']['user'] do
  gid node['tomcat']['server']['group']
  action :create
end

# Download Tomcat binary and sample.war
remote_file node['tomcat']['server']['binary']['local_path'] do
  source node['tomcat']['server']['binary']['source']
  checksum node['tomcat']['server']['binary']['checksum']
  action :create
end

remote_file node['tomcat']['server']['sample_war']['local_path'] do
  source node['tomcat']['server']['sample_war']['source']
  checksum node['tomcat']['server']['sample_war']['checksum']
  action :create
end

# Extract binary
directory node['tomcat']['server']['install_directory'] do
  recursive true
  action :create
end

execute 'Extract Tomcat binary' do
  command "tar xvf #{node['tomcat']['server']['binary']['local_path']} -C #{node['tomcat']['server']['install_directory']} --strip-components=1"
  action :run
  creates "#{node['tomcat']['server']['install_directory']}/LICENSE"
end

# Set permissions
execute "chgrp install dir to #{node['tomcat']['server']['group']}" do
  command "chgrp -R #{node['tomcat']['server']['group']} #{node['tomcat']['server']['install_directory']}"
  action :run
  not_if { Etc.getgrgid(::File.stat("#{node['tomcat']['server']['install_directory']}/LICENSE").gid).name == node['tomcat']['server']['group'] }
end

execute "chown install dir to #{node['tomcat']['server']['user']}" do
  command "chown -R #{node['tomcat']['server']['user']} #{node['tomcat']['server']['install_directory']}"
  action :run
  not_if { Etc.getpwuid(::File.stat("#{node['tomcat']['server']['install_directory']}/LICENSE").uid).name == node['tomcat']['server']['user'] }
end

# Create Systemd unit file
template '/etc/systemd/system/tomcat.service' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[Reload systemd config]', :immediately
  notifies :restart, 'service[tomcat]'
end

# Manage service
execute 'Reload systemd config' do
  command 'systemctl daemon-reload'
  action :nothing
end

service 'tomcat' do
  action [:start, :enable]
end

# Configure Tomcat port
template "#{node['tomcat']['server']['install_directory']}/conf/server.xml" do
  owner node['tomcat']['server']['user']
  group node['tomcat']['server']['group']
  mode '0600'
  action :create
  notifies :restart, 'service[tomcat]'
end
