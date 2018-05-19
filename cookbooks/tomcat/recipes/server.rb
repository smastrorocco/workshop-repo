#
# Cookbook:: tomcat
# Recipe:: server
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install OpenJDK
package node['tomcat']['openjdk']['package'] do
  action :install
end

# Create Tomcat group/user
group node['tomcat']['group'] do
  append true
  action :create
end

user node['tomcat']['user'] do
  gid node['tomcat']['group']
  action :create
end

# Download Tomcat binary and sample.war
remote_file node['tomcat']['binary']['local_path'] do
  source node['tomcat']['binary']['source']
  checksum node['tomcat']['binary']['checksum']
  action :create
end

remote_file node['tomcat']['sample_war']['local_path'] do
  source node['tomcat']['sample_war']['source']
  checksum node['tomcat']['sample_war']['checksum']
  action :create
end

# Extract binary
directory node['tomcat']['install_directory'] do
  recursive true
  action :create
end

execute 'Extract Tomcat binary' do
  command "tar xvf #{node['tomcat']['binary']['local_path']} -C #{node['tomcat']['install_directory']} --strip-components=1"
  action :run
  creates "#{node['tomcat']['install_directory']}/LICENSE"
end

# Set permission
