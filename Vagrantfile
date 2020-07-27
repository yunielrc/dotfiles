require_relative 'lib/patches.rb'

Vagrant.configure("2") do |config|
  config.vm.box = "dummy"

  config.vm.provider :aws do |aws, override|
    # aws.access_key_id = "YOUR KEY"
    # aws.secret_access_key = "YOUR SECRET KEY"
    aws.instance_type = "c5.xlarge"
    aws.keypair_name = "yuniel@yuniel-Z370-AORUS-Gaming-5"
    aws.region = "us-east-2"
    aws.ami = "ami-01237fce26136c8cc"
    aws.security_groups = ['default']

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/id_rsa"
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder "./", "/home/ubuntu/.dotfiles"
  config.vm.provision :shell, path: "./lib/provision.bash", privileged: false
end
