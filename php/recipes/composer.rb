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
