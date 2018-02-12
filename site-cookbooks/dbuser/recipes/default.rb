cookbook_file "/tmp/install_dbuser.sh" do
  source "install_dbuser.sh"
  mode '0777'
end

bash 'install_dbuser' do
  cwd '/tmp'
  code <<-EOH
  sh ./install_dbuser.sh
  EOH
end
