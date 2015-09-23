#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, Corus Entertainment | Nelvana Digital
# Author: Aidan Holsgrove
#
#

processors_file = "/tmp/processors_file"

file processors_file do
  owner 'root'
  group 'root'
  mode "775"
end