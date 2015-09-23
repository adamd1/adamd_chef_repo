#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, Corus Entertainment | Nelvana Digital
# Author: Aidan Holsgrove
#
#

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action   :restart
end