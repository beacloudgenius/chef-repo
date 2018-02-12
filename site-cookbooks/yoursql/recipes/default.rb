# Configure the MySQL client.
mysql_client 'default' do
  action :create
end

# Configure the MySQL service.

# Customization: get passwords from encrypted data bag
secrets = Chef::EncryptedDataBagItem.load("secrets", "mysql")
if secrets && mysql_passwords = secrets[node.chef_environment]
  node.set['mysql']['server_root_password'] = mysql_passwords['root']
  node.set['mysql']['server_debian_password'] = mysql_passwords['debian']
  node.set['mysql']['server_repl_password'] = mysql_passwords['repl']
end

mysql_service 'default' do
  version '5.7'
  bind_address '0.0.0.0'
  port '3306'
  initial_root_password mysql_passwords['root']
  action [:create, :start]
end
