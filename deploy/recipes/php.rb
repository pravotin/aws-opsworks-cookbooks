#
# Cookbook Name:: deploy
# Recipe:: php
#

include_recipe 'deploy'
#TODO: Pravotin-12/28: Need to use a if block based on server parameter to either start apache mods or not.
#include_recipe "mod_php5_apache2"
#include_recipe "mod_php5_apache2::php"

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end

  #Run composer to pull dependencies. 
  include_recipe 'php::composer'

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end
end

