#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, Corus Entertainment | Nelvana Digital
# Author: Aidan Holsgrove
#
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
### Php Processes

maxchildren_file = "/tmp/maxchildren_file"

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
else 
	process_avg_mb =  70
end


# Max Children = Total Server Memory in KB / 75% * 0.01 to find MB, then divided by process average mb usage
execute "find maxchildren" do
	#command "sudo grep MemTotal /proc/meminfo | awk '{printf "%0.f", ($2*0.75)*0.01/#{process_avg_mb}}'  > #{maxchildren_file}"
	#command 'sudo grep MemTotal /proc/meminfo | awk {printf "%0.f",sub(/\r$/, "") ($2*0.75)*0.01/70}" > #{maxchildren_file}'
	command	"sudo sh /tmp/bash1.sh"
    #command "sudo grep MemTotal /proc/meminfo | awk '{print ($2*0.75)*0.01/#{process_avg_mb}}' > #{maxchildren_file}"
end

#########################################################################################