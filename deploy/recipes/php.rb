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

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  #Run PHP Composer for this PHP app.
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    php composer.phar install -n --optimize-autoloader --prefer-source
    EOH
  end

end

