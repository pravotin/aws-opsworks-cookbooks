include_recipe "php::fpm-service"

service "php-fpm" do
  action :start
end
