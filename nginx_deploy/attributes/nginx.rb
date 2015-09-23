###
# Do not use this file to override the corus_nginx cookbook's default
# attributes.  Instead, please use the customize.rb attributes file,
# which will keep your adjustments separate from the AWS OpsWorks
# codebase and make it easier to upgrade.
#
# However, you should not edit customize.rb directly. Instead, create
# "corus_nginx/attributes/customize.rb" in your cookbook repository and
# put the overrides in YOUR customize.rb file.
#
# Do NOT create an 'corus_nginx/attributes/corus_nginx.rb' in your cookbooks. Doing so
# would completely override this file and might cause upgrade issues.
#
# See also: http://docs.aws.amazon.com/opsworks/latest/userguide/customizing.html
###

case node['platform_family']
when "debian"
  default['corus_nginx']['dir']        = "/etc/nginx"
  default['corus_nginx']['log_dir']    = "/var/log/nginx"
  default['corus_nginx']['user']       = "www-data"
  default['corus_nginx']['binary']     = "/usr/sbin/nginx"
  if node['platform_version'] == "14.04"
    default['corus_nginx']['pid_file'] = "/run/nginx.pid"
  else
    default['corus_nginx']['pid_file'] = "/var/run/nginx.pid"
  end
when "rhel"
  default['corus_nginx']['dir']        = "/etc/nginx"
  default['corus_nginx']['log_dir']    = "/var/log/nginx"
  default['corus_nginx']['user']       = "nginx"
  default['corus_nginx']['binary']     = "/usr/sbin/nginx"
  default['corus_nginx']['pid_file']   = "/var/run/nginx.pid"
else
  Chef::Log.error "Cannot configure corus_nginx, platform unknown"
end

default['corus_nginx']['log_format'] = {}

# increase if you accept large uploads
default['corus_nginx']['client_max_body_size'] = "4m"

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

default['corus_nginx']['keepalive'] = "on"
default['corus_nginx']['keepalive_timeout'] = 30


case node['hostname']
  when  (/localhost/)
    default['corus_nginx']['server_names_hash_bucket_size'] = 96
  else
    default['corus_nginx']['server_names_hash_bucket_size'] = 64
end


default['corus_nginx']['proxy_read_timeout'] = 60
default['corus_nginx']['proxy_send_timeout'] = 60

include_attribute "corus_nginx::customize"
