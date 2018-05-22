#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'java::default'

package 'httpd' do
  action :install
end

service 'httpd' do
  action [:start, :enable]
end

template '/var/www/html/index.html' do
  action :create
end
