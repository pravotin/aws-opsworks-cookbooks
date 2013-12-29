#
# Cookbook Name:: php
# Recipe:: fpm-service
#
# Install PHP 5.5 and Mysql. 
# 
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform_family?("rhel")
  php_fpm_service_name = "php-fpm-5.5"
else
  php_fpm_service_name = "php5-fpm"
end

service "php-fpm" do
  service_name php_fpm_service_name
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

