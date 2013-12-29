#
# Cookbook Name:: php::setup
# Recipe:: default
#
# Install PHP 5.5 and Mysql. 
# 
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mysql::client"

if platform?("ubuntu") 
  execute "apt-get update" do
    action :nothing
    command "apt-get update"
  end
  
  # Use PHP 5.4
  #apt_repository "php54" do
  #  uri "http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu"
  #  distribution node['lsb']['codename']
  #  components ["main"]
  #  keyserver "keyserver.ubuntu.com"
  #  key "E5267A6C"
  #end

  apt_repository "ondrej-php-#{node["lsb"]["codename"]}" do
    uri "http://ppa.launchpad.net/ondrej/php5/ubuntu"
    distribution node["lsb"]["codename"]
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "E5267A6C"
    action :add
    notifies :run, "execute[apt-get update]", :immediately
  end

end

node['php']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

