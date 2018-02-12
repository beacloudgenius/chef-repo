node.default['main']['doc_root'] = "/var/www/"

directory node['main']['doc_root'] do
 owner 'www-data'
 group 'www-data'
 mode '0644'
 action :create
end

apache_module "mpm_event" do
  enable false
end

apache_module "mpm_prefork" do
  enable true
end

node.default['apache']['mpm'] = 'prefork'

template "/etc/apache2/sites-available/cloudgenius.conf" do
 source "vhost.erb"
 variables({ :doc_root => node['main']['doc_root'] })
 action :create
 notifies :restart, resources(:service => "apache2")
end

bash "enable-sites" do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  #!/bin/bash
  a2ensite cloudgenius.conf
  service apache2 reload
  EOH
end

bash 'install_wp' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  #!/bin/bash
  if [ -f /var/www/wp-config.php ]
  then
    echo "I will do nothing because you already have wordpress"
  else
    echo "You do not seem to have WordPress installed already"
    echo "so I am going to install it for you"

    wget https://wordpress.org/wordpress-4.9.4.tar.gz
    tar xfz wordpress-4.9.4.tar.gz
    rm -f wordpress-4.9.4.tar.gz

    rm -rf /var/www
    mv wordpress /var/www
    chown -R www-data:www-data /var/www
  fi
  EOH
end
