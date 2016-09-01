# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.provision :shell, path: "conf/install.sh"
  config.vm.network :forwarded_port, guest: 80, host: 8888
end
