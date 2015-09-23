###
# This is the place to override the corus_nginx cookbook's default attributes.
#
# Do not edit THIS file directly. Instead, create
# "corus_nginx/attributes/customize.rb" in your cookbook repository and
# put the overrides in YOUR customize.rb file.
###

# The following shows how to disable corus_nginx compression:
#
#normal['corus_nginx']['gzip'] = 'off'
#normal['corus_nginx']['gzip_static'] = 'off'
default['corus_nginx']['data_drive'] = "/data"
default['corus_nginx']['data_www'] = "/data/www"
default['corus_nginx']['site_logs'] = "/data/logs"
default['corus_nginx']['data_shared'] = "/data/shared"
default['corus_nginx']['hotbackups'] = "/data/hotbackups"
default['corus_nginx']['gen_backups'] = "/data/backups"
default['corus_nginx']['sites_available'] = "/etc/nginx/sites-available"
default['corus_nginx']['sites_enabled'] = "/etc/nginx/sites-enabled"


default['corus_nginx']['keepalive'] = "on"
default['corus_nginx']['keepalive_timeout'] = 30

# increase if you accept large uploads
default['corus_nginx']['client_max_body_size'] = "4m"
default['corus_nginx']['server_names_hash_bucket_size'] = 64

default['corus_nginx']['proxy_read_timeout'] = 60
default['corus_nginx']['proxy_send_timeout'] = 60


#case node['opsworks']['instance']['instance_type']
case node['instance_type']
when "t2.medium"
   default['corus_nginx']['corus_worker_processes'] = 2
   default['corus_nginx']['worker_connections'] = 2048
when "c3.large"
   default['corus_nginx']['corus_worker_processes'] = 2
   default['corus_nginx']['worker_connections'] = 2048
when "c3.xlarge"
   default['corus_nginx']['corus_worker_processes'] = 4
   default['corus_nginx']['worker_connections'] = 4096
when "c3.2xlarge"
   default['corus_nginx']['corus_worker_processes'] = 4
   default['corus_nginx']['worker_connections'] = 4096
else
   default['corus_nginx']['corus_worker_processes'] = 3
   default['corus_nginx']['worker_connections'] = 2048
end

default['corus_nginx']['log_format'] = {}

default['corus_nginx']['gzip'] = "on"
default['corus_nginx']['gzip_static'] = "on"
default['corus_nginx']['gzip_vary'] = "on"
default['corus_nginx']['gzip_disable'] = "MSIE [1-6'].(?!.*SV1)"
default['corus_nginx']['gzip_http_version'] = "1.0"
default['corus_nginx']['gzip_comp_level'] = "5"
default['corus_nginx']['gzip_proxied'] = "any"
default['corus_nginx']['gzip_types'] = ["application/x-javascript",
                                "application/x-pointplus",
                                "application/javascript",
                                "application/json",
                                "application/xhtml+xml",
                                "application/xml",
                                "application/xml+rss",
                                "application/ecmascript",
                                "text/css",
                                "text/javascript",
                                "text/ecmascript",
                                "text/plain",
                                "text/xml",
                                "image/jpeg",
                                "image/png",
                                "image/jpg",
                                "image/gif",
                                "image/pdf"]
# corus_nginx will compress "text/html" by default
