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

    wget https://wordpress.org/wordpress-4.5.3.tar.gz
    tar xfz wordpress-4.5.3.tar.gz
    rm -f wordpress-4.5.3.tar.gz

    rm -rf /var/www
    mv wordpress /var/www
    chown -R www-data:www-data /var/www
  fi
  EOH
end
