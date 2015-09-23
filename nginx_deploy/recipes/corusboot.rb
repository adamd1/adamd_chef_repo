#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, Corus Entertainment | Nelvana Digital
# Author: Aidan Holsgrove
#
#
########################################################################################
### Create Templates

processors_file = "/tmp/processors_file"
file processors_file do
  owner 'root'
  group 'root'
  mode "775"
end

maxchildren_file = "/tmp/maxchildren_file.sh"
template "maxchildrencalculator.sh" do
  path "/tmp/maxchildrencalculator.sh"
  source "maxchildrencalculator.sh.erb"
  owner "root"
  group "root"
  mode "644"
end

phpmemtotal_file = "/tmp/phpmemtotal_file"
file phpmemtotal_file do
  owner 'root'
  group 'root'
  mode "775"
end

########################################################################################
### Php totals

phpmemtotal_file = "/tmp/phpmemtotal_file"

execute "find memtotal" do
    command "sudo grep MemTotal /proc/meminfo | awk '{print $2*0.75}' > #{phpmemtotal_file}"
end

if File.exist?(phpmemtotal_file) then 
  file = File.open(phpmemtotal_file, 'rb')
  phpmemtotal = file.read
end

########################################################################################
### Nginx Processes

execute "find processors" do
    command "sudo nproc | awk '{print $1}' > /tmp/processors_file"
end

#maxchildren_file = "/tmp/maxchildren_file"

case node['hostname']
when "corusdrupaladults"
    process_avg_mb = 50
when "corusdrupkids"
  process_avg_mb =  50
when "corusdrupalteens"
  process_avg_mb =  50
when "corusdrupalwomens"
  process_avg_mb =  100
when "coruswpdigital"
  process_avg_mb =  50
else #must be local host
  process_avg_mb =  70
end


# Nginx Max Children = Total Server Memory in KB / 75% * 0.01 to find MB, then divided by process average mb usage
execute "find maxchildren" do
    command "sudo sh /tmp/maxchildrencalculator.sh"
  end

#########################################################################################
