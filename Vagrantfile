require_relative 'lib/vagrant/patches.rb'

$script = <<-SCRIPT
  cat "/home/ubuntu/.dotfiles/.env.override.server" >> "/home/ubuntu/.dotfiles/.env"
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "dummy"

  config.vm.provider :aws do |aws, override|
    # aws.access_key_id = "YOUR KEY"
    # aws.secret_access_key = "YOUR SECRET KEY"
    aws.instance_type = "c5.xlarge"
    aws.keypair_name = "yuniel@yuniel-Z370-AORUS-Gaming-5"
    aws.region = "us-east-2"
    aws.ami = "ami-01237fce26136c8cc"
    aws.block_device_mapping = [{ 'DeviceName' => '/dev/sda1', 'Ebs.VolumeSize' => 16 }]
    aws.security_groups = ['default']

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/id_rsa"
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder "./", "/home/ubuntu/.dotfiles"
  config.vm.provision "shell", inline: $script

  # this vm is reusable, everything runs inside docker
  config.vm.define "docker", primary: true do |docker|
    docker.vm.provision :shell, path: "./lib/vagrant/provision-ubuntu-docker.bash", privileged: false
  end
  # this vm is not reusable, everything runs directly inside the vm
  config.vm.define "vnc", autostart: false do |vnc|
    vnc.vm.provision :shell, path: "./lib/vagrant/provision-ubuntu-desktop-vnc.bash", privileged: false
  end
end
