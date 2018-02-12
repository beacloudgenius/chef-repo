bundle exec knife digital_ocean droplet destroy cloudgenius -y
rm -rf ~/.ssh/known_hosts

bundle exec knife node delete cloudgenius -y
bundle exec knife client delete cloudgenius -y

bundle exec knife role from file roles/*.rb
bundle exec knife cookbook upload -o ./site-cookbooks/ --all

bundle exec knife digital_ocean droplet create \
    --server-name cloudgenius \
    --image ubuntu-16-04-x64 \
    --location sfo2 \
    --size 1gb \
    --bootstrap \
    --identity-file "~/.ssh/id_rsa" \
    --ssh-keys 18130646 \
    --environment prod \
    --run-list 'role[base], role[db_master], role[webserver]'
