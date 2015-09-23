#execute "instancetypetest" do
  #hostname = ("#{node['opsworks']['instance']['hostname']}")
  #instance_type = ("#{node['opsworks']['instance']['instance_type']}")
  instancetest = '/tmp/instancetest.txt'
 File.open(instancetest, 'a+') do |fo|
    fo.puts "#{node['opsworks']['instance']['hostname']}\n"
    fo.puts "#{node['opsworks']['instance']['instance_type']}\n"
    fo.puts "#{node['opsworks']['instance']['platform_family']}\n"
    fo.puts "#{node['hostname']}\n"
    fo.puts "#{node['instance_type']}\n"
    fo.puts "#{node['platform_family']}\n"
     end
#end

  processortest = '/tmp/processortest.txt'

  processors = { cat /proc/cpuinfo | grep processor | wc -l }

  execute "processors" do
    command "sudo #{processors} > #{processors}"
  end