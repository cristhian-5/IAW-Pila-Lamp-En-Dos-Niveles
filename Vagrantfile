# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  config.vm.define "apache" do |apache|
    apache.vm.hostname = "CristhianCarvajalBarraganApache"
    
    apache.vm.network "private_network", ip: "192.168.56.10"
    
    apache.vm.network "forwarded_port", guest: 80, host: 8080

    apache.vm.provision "shell", path: "scripts/provision_apache.sh"
  end

  config.vm.define "mysql" do |mysql|
    mysql.vm.hostname = "CristhianCarvajalBarraganMysql"
    
    mysql.vm.network "private_network", ip: "192.168.56.20"

    mysql.vm.provision "shell", path: "scripts/provision_mysql.sh"
  end
end