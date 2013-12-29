include_attribute 'deploy'

default[:opsworks][:server][:name] = 'nginx'
case node["platform_family"]
  when "rhel"
    default['php']['packages'] = ['php55', 'php55-devel', 'php55-cli', 'php55-fpm', 'php55-mysqlnd', 'php-pear']
  when "debian"
    default['php']['packages'] = ['php5-cgi', 'php5', 'php5-curl', 'php5-dev', 'php5-cli', 'php5-mysql', 'php5-fpm', 'php-pear']
end
