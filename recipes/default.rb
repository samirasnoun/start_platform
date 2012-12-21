#
# Cookbook Name:: start_platforme
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute


#node.set[:list] = ["dea_java" ,  "dea_ruby" , "dea_node" , "dea_php" , "dea_python" ]

require "rubygems"
require 'json'

 node.set['dea']['runtimes'] = []
node.set['dea']['frameworks'] = []
node.set[:cloud_controller][:service_api_uri] = "http://api.#{node[:deployment][:domain]}"

node[:list].each do |cn|
  case cn
  when 'dea_ruby'
    node.set['dea']['runtimes'] = ['ruby18', 'ruby19', 'ruby193'] + node['dea']['runtimes']
    node.set['dea']['frameworks'] =  ['sinatra'] + node['dea']['frameworks']
  when 'dea_java'
    node.set['dea']['runtimes'] = ['java', 'java7'] + node['dea']['runtimes']
    node.set['dea']['frameworks'] = ['spring'] + node['dea']['frameworks']
  when 'dea_node'
    node.set['dea']['runtimes'] = ['node04', 'node06', 'node08'] + node['dea']['runtimes']
    node.set['dea']['frameworks'] = ['node'] + node['dea']['frameworks']
  when 'dea_php'
    node.set['dea']['runtimes'] = ['php'] + node['dea']['runtimes']
    node.set['dea']['frameworks'] = ['php'] + node['dea']['frameworks']
  when 'dea_python'
    node.set['dea']['runtimes'] =  ['python2'] + node['dea']['runtimes']
    node.set['dea']['frameworks'] = ['python'] + node['dea']['frameworks']
  when 'dea_aspdotnet'
    node.set['dea']['runtimes'] =  ['aspdotnet'] + node['dea']['runtimes']
    node.set['dea']['frameworks'] = ['aspdotnet'] + node['dea']['frameworks']
  end
end

 node.set['dea']['frameworks'] = node['dea']['frameworks'].uniq
 node.set['dea']['runtimes'] = node['dea']['runtimes'].uniq
 node.set[:nats_server][:host]       = node[:ipaddress]
 node.save




template "runtimes.yml" do
   path File.join("/root/cloudfoundry/.deployments/allinone/config", "runtimes.yml")
   source "runtimes.yml.erb"
   owner node[:deployment][:user]
   mode 0644
end


#staging_dir = File.join("/root/cloudfoundry/.deployments/allinone/config", "staging")
#node[:cloud_controller][:staging].each_pair do |framework, config|
#  template config do
#    path File.join(staging_dir, config)
#    source "#{config}.erb"
#    owner node[:deployment][:user]
#    mode 0644
#  end
#end



staging_dir = File.join("/root/cloudfoundry/.deployments/allinone/config", "staging")
node['dea']['frameworks'].each do |config|
  template "#{config}.yml" do
    path File.join(staging_dir, "#{config}.yml")
    source "#{config}.yml.erb"
    owner node[:deployment][:user]
    mode 0644
  end
end



config_dir = "/root/cloudfoundry/.deployments/allinone/config"
node[:configs].each do |config|
  template config do
    path File.join(config_dir, config)
    source "#{config}.erb"
    owner node[:deployment][:user]
    mode 0644
  end
end



#template "/root/cloudfoundry/.deployments/allinone/config/cloud_controller.yml" do
#    path "/root/cloudfoundry/.deployments/allinone/config/cloud_controller.yml"
 #   source "cloud_controller.yml.erb"
 #   owner node[:deployment][:user]
 #   mode 0644
 # end
#config_postgres = "/etc/postgresql/8.4/main/postgresql.conf"
template "/etc/postgresql/8.4/main/postgresql.conf" do
#    path "/root/cloudfoundry/.deployments/allinone/config/nats_server/nats_server.yml"
    source "postgresql.conf.erb"
    owner node[:deployment][:user]
    mode 0644
  end

template "/etc/postgresql/8.4/main/postgresql.conf" do
  notifies :restart, "service[postgresql-8.4]", :immediately
end
 
service "postgresql-8.4"

template "/root/cloudfoundry/.deployments/allinone/config/nats_server/nats_server.yml" do
    path "/root/cloudfoundry/.deployments/allinone/config/nats_server/nats_server.yml"
    source "nats_server.yml.erb"
    owner node[:deployment][:user]
    mode 0644
  end


template "/etc/hosts" do
    path "/etc/hosts"
    source "etc.erb"
    owner node[:deployment][:user]
    mode 0644
  end


#node[:components] = ["dea","mongodb_gateway"]

#Create json_component 

components = node[:components]

jcomponents = components.to_json
jjcomponents = "{\"components\":" + jcomponents + "}"


fJson = File.open("/root/cloudfoundry/.deployments/allinone/config/vcap_components.json","w")
fJson.write(jjcomponents)
fJson.close


bash "start platform  " + node[:deployment][:domain]  do
  user "root" 
  cwd "/tmp" 
  code <<-EOH
  nohup /root/cloudfoundry/vcap/dev_setup/bin/vcap_dev -n allinone restart 
  EOH
end

bash "status platform  " + node[:deployment][:domain] do
  user "root" 
  cwd "/tmp" 
  code <<-EOH
  /root/cloudfoundry/vcap/dev_setup/bin/vcap_dev -n allinone status
  EOH
end
