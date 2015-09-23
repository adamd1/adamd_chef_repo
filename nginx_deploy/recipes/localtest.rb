#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, Corus Entertainment | Nelvana Digital
# Author: Aidan Holsgrove
#


#package "nginx" do
#  action :install
#end

#template "nginx.conf" do
#  path "/etc/nginx/nginx.conf"
#  source "nginx.conf.erb"
#  owner "root"
#  group "root"
#  mode "644"
#end

directory node['nginx']['log_dir'] do
  mode "755"
  owner node['nginx']['user']
  action :create
end

directory node['nginx']['dir'] do
  owner 'root'
  group 'root'
  mode '"755"'
end

directory node['nginx']['data_drive'] do
  mode "755"
  owner node['nginx']['user']
  action :create
end

directory node['nginx']['data_shared'] do
  mode "755"
  owner node['nginx']['user']
  action :create
end

directory node['nginx']['hotbackups'] do
  mode "755"
  owner node['nginx']['user']
  action :create
end

directory node['nginx']['site_logs'] do
  mode "755"
  owner node['nginx']['user']
  action :create
end

#template "blacklist.conf" do
#  path "/etc/nginx/blacklist.conf"
#  source "blacklist.conf.erb"
#  owner "root"
#  group "root"
#  mode "644"
#end
