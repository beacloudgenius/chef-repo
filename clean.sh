rm -rf ~/.ssh/known_hosts
bundle exec knife node delete docloudgenius -y
bundle exec knife client delete docloudgenius -y

bundle exec knife node delete ec2cloudgenius -y
bundle exec knife client delete ec2cloudgenius -y

bundle exec knife role from file roles/*.rb
bundle exec knife cookbook upload -o ./site-cookbooks/ --all


bundle exec knife digital_ocean droplet destroy --all
bundle exec knife ec2 server delete -N ec2cloudgenius -y
