
DOCKER_COMPOSE_VERSION ="v2.16.0"
NODE_EXPORTER_VERSION = "1.4.1"
GRAFANA_VERSION = "latest"

Vagrant.configure("2") do |config|
  # используем образ Ubuntu 20.04 от generic
  config.vm.box = "generic/d3b5d3ab-43a0-4bfb-b1b7-4374f0a38545"
  config.vm.hostname = "ubuntu"
  # Network Configuration
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 9100, host: 9100
  config.vm.network "forwarded_port", guest: 9090, host: 9090
  
config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
        vb.cpus = 2
          end

config.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update
        sudo apt-get install -y net-tools
        sudo apt-get -y install jq
                  SHELL

config.vm.provision "file", source: "scripts", destination: "/home/vagrant/scripts"
config.vm.provision "file", source: "docker", destination: "/home/vagrant/docker"
config.vm.provision "file", source: "configs", destination: "/home/vagrant/configs"

config.vm.provision "ansible" do |ansible|

    ansible.inventory_path = "ansible/inventory"

    ansible.playbook = "ansible/playbook.yml"

    ansible.extra_vars = {
    docker_compose_version: DOCKER_COMPOSE_VERSION,
    node_exporter_version: NODE_EXPORTER_VERSION,
    grafana_version: GRAFANA_VERSION
    }
end

end

