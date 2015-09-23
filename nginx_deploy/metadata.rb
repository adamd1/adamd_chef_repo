name             'corus_nginx'
maintainer       'Corus Entertainment'
maintainer_email 'aidan.holsgrove@corusent.com'
license          'All rights reserved'
description      'Installs/Configures nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

depends "corus_php_fpm"

attribute "nginx/dir",
  :display_name => "Nginx Directory",
  :description => "Location of nginx configuration files",
  :default => "/etc/nginx"

 attribute "nginx/log_dir",
  :display_name => "Nginx Log Directory",
  :description => "Location for nginx logs",
  :default => "/var/log/nginx"