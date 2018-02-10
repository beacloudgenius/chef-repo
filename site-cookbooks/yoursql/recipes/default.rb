# Customization: get passwords from encrypted data bag
secrets = Chef::EncryptedDataBagItem.load("secrets", "mysql")
if secrets && mysql_passwords = secrets[node.chef_environment]
  node.set['mysql']['server_root_password'] = mysql_passwords['root']
  node.set['mysql']['server_debian_password'] = mysql_passwords['debian']
  node.set['mysql']['server_repl_password'] = mysql_passwords['repl']
end



include_recipe "mysql::server"
