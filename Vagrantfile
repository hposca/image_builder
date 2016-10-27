# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
  sudo apt-get update
  sudo apt-get install -y python-pip
  export LC_ALL=C
  sudo pip install pip --upgrade
  sudo pip install ansible --upgrade
SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
  else
    config.vm.synced_folder ".", "/vagrant"
  end

  config.vm.define "test" do |machine|
      machine.vm.box = "bento/ubuntu-16.04"
      machine.vm.hostname = "image-builder"
      machine.vm.network "private_network", ip: "172.20.20.11"
      machine.vm.provision "shell", inline: $script
      machine.vm.provider "virtualbox" do |v|
        v.memory = 1024
      end
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.no_install = true
    config.vbguest.no_remote = true
  end
end
