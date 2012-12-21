default[:cloud_controller][:admins] = ["dev@cloudfoundry.org"]
default[:deployment][:domain] = "vcap.me"
default[:cloud_controller][:service_api_uri] = "http://api.#{node[:deployment][:domain]}"
default[:deployment][:welcome] = "Thales VMware s Cloud Application Platform"
default[:service_broker][:host] = "service-broker"
default[:list] = ["dea_java" ,  "dea_ruby" , "dea_node" , "dea_php" , "dea_python" ]
default['dea']['runtimes'] = ["ruby18", "ruby19", "ruby193", "node04", "node06", "node08", "java", "java7", "erlang", "php", "python2"]
default['dea']['frameworks'] = ["python" , "aspdotnet" , "php" , "spring" , "sinatra"]
#default['cloud_controller']["gateways"] = ["vblob_gateway.yml" , "mongodb_gateway.yml" , "rabbitmq_gateway.yml" , "vblob_node.yml" ,  "mysql_gateway.yml"  , "redis_gateway.yml"]
default['configs'] = ["dea.yml","mongodb_gateway.yml","rabbitmq_node.yml","cloud_controller.yml","stager.yml","mysql_gateway.yml","postgresql_gateway.yml","service_broker.yml","mongodb_node.yml","health_manager.yml","mysql_node.yml","postgresql_node.yml","vblob_node.yml","router.yml","redis_node.yml","rabbitmq_gateway.yml","uaa.yml","redis_gateway.yml","vblob_gateway.yml"]

default[:services] = ["dea","mongodb_gateway","rabbitmq_node","cloud_controller","stager","mysql_gateway","postgresql_gateway","service_broker","mongodb_node","health_manager","mysql_node","postgresql_node","vblob_node","router","redis_node","rabbitmq_gateway","uaa","redis_gateway","vblob_gateway"]


default[:nats_server][:host]       = "0.0.0.0"

default[:cloud_controller][:staging][:grails] = "grails.yml"
default[:cloud_controller][:staging][:lift] = "lift.yml"
default[:cloud_controller][:staging][:node] = "node.yml"
default[:cloud_controller][:staging][:otp_rebar] = "otp_rebar.yml"
default[:cloud_controller][:staging][:rack] = "rack.yml"
default[:cloud_controller][:staging][:rails3] = "rails3.yml"
default[:cloud_controller][:staging][:sinatra] = "sinatra.yml"
default[:cloud_controller][:staging][:spring] = "spring.yml"
default[:cloud_controller][:staging][:java_web] = "java_web.yml"
default[:cloud_controller][:staging][:php] = "php.yml"
default[:cloud_controller][:staging][:django] = "django.yml"
default[:cloud_controller][:staging][:wsgi] = "wsgi.yml"
default[:cloud_controller][:staging][:standalone] = "standalone.yml"
default[:cloud_controller][:staging][:play] = "play.yml"
