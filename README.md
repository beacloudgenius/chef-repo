bundle exec knife ec2 server create \
       -S id_rsa \
       -i /home/user/.ssh/id_rsa \
       -x ubuntu \
       -I ami-c62eaabe \
       -f t2.micro \
       -r "recipe[nginx]"

bundle exec knife digital_ocean droplet create \
    --server-name docloudgenius \
    --image ubuntu-16-04-x64 \
    --location sfo2 \
    --size 1gb \
    --bootstrap \
    --identity-file "~/.ssh/id_rsa" \
    --ssh-keys 18130646 \
    --environment prod \
    --run-list 'role[base], role[db_master], role[webserver]'

bundle exec knife ec2 server create \
      -S id_rsa \
      -i ~/.ssh/id_rsa \
      -N ec2cloudgenius
      -x ubuntu \
      -I ami-c62eaabe \
      -f t2.micro \
      --environment prod \
      --run-list 'role[base], role[db_master], role[webserver]'
