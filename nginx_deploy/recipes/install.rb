#
# Cookbook Name:: corus_nginx
#
# Recipe:: default
#
# Copyright 2014, Corus Entertainment | Nelvana Digital
# Author: Aidan Holsgrove
#
#
#include_recipe "processorsfile"

# user 'nginx' do
#   comment 'corus nginx son!'
#   uid "496"
#   system true
#   shell '/bin/false'
# end                

group 'nginx' do
  system true
  gid "496"
end

user 'nginx' do
  comment 'nginx user son'
  uid "496"
  gid "nginx"
  system true
  shell '/bin/false'
  not_if "getent passwd nginx"
end

package "nginx" do
  action :install
end

########################################################################################
### corus_nginx Processors 

processors_file = "/tmp/processors_file"

execute "find processors" do
    command "sudo nproc | awk '{print $1}' > /tmp/processors_file"
end

template "corus_nginx.conf" do
  path "/etc/nginx/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "644"
  variables(
    lazy {
      file = File.open(processors_file, 'rb')
      processornum = file.read 
      { :processornum => "#{processornum}" }
         }
    )
end

########################################################################################
### corus_nginx and shard drive directories

directory node['corus_nginx']['dir'] do
  owner node['corus_nginx']['user']
  group node['corus_nginx']['user']
  mode "755"
end

directory node['corus_nginx']['sites_available'] do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
end

directory node['corus_nginx']['sites_enabled'] do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
end

directory node['corus_nginx']['log_dir'] do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
end

directory node['corus_nginx']['data_drive'] do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
end

if node['hostname'].include? "local" then # Don't run this if it's local host
else
directory node['corus_nginx']['data_www'] do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
 # only_if { node['hostname'].include? != "local"}
end
directory node['corus_nginx']['hotbackups'] do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
  #not_if { node['hostname'].include? != "local"}
end
end

directory node['corus_nginx']['data_shared'] do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
 # not_if { node['hostname'].include? != "local"}
end


directory node['corus_nginx']['gen_backups'] do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
end

directory node['corus_nginx']['site_logs'] do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
end


##########################################################################
### corus_nginx Site Template

hostname = node['hostname']
server_root = "/data/www/#{hostname}"
site_config = "/etc/nginx/sites-enabled/#{hostname}"

## Create website log directory
directory "#{server_root}" do
  mode "755"
  owner node['corus_nginx']['user']
  action :create
end


if node['hostname'].include? "local" then # Don't run this if it's local host
else
  
# When it's not localhost, install the php test site
    template "server default site config" do
      path "/etc/nginx/sites-available/#{hostname}"
      source "corusserversiteconf.erb"
      owner "root"
      group "root"
      mode "644"
      variables(
           :hostname => node['hostname']
        )
    end

    ## Create sym link in sites-enabled
    execute "symlink sites-enabled" do
      command "sudo ln -s /etc/nginx/sites-available/#{hostname} /etc/nginx/sites-enabled/#{hostname}"
      not_if do File.symlink?("#{site_config}") end
    end

    ##########################################################################
    ### Server Test page
    template "server test page" do
      path "/data/www/#{hostname}/test.php"
      source "testpage.erb"
      owner "nginx"
      group "nginx"
      mode "755"
      variables(
           :hostname => node['hostname']
        )
    end
end # End "if it's not localhost"

########################################################################################
### corus_nginx templates

template "blacklist.conf" do
  path "/etc/nginx/blacklist.conf"
  source "blacklist.conf.erb"
  owner "root"
  group "root"
  mode "644"
end


