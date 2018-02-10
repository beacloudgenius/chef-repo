cookbook_file "/tmp/install_dbuser.sh" do
  source "install_dbuser.sh"
  mode '0700'
  owner 'user'
  group 'user'
end

bash 'install_dbuser' do
  user 'user'
  cwd '/tmp'
  code <<-EOH
  sh ./install_dbuser.sh
  EOH
end
