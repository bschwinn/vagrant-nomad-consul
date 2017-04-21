# -*- mode: ruby -*-
# vi: set ft=ruby :

$scriptbase = <<SCRIPT

# Update apt and get dependencies
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y unzip curl wget vim

# Download Consul
echo Fetching Consul...
cd /tmp/
curl -sSL https://releases.hashicorp.com/consul/0.8.0/consul_0.8.0_linux_amd64.zip -o consul.zip

echo Installing Consul...
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul

sudo mkdir -p /tmp/consul
sudo chmod a+w /tmp/consul

extraArgs=""
if [ "$2x" != "x" ]; then
  extraArgs=" -server -bootstrap-expect $2"
fi

consul agent -data-dir="/tmp/consul" -advertise $1 $extraArgs &

SCRIPT

$scriptnom = <<SCRIPT
# Download Nomad
echo Fetching Nomad...
cd /tmp/
curl -sSL https://releases.hashicorp.com/nomad/0.5.6/nomad_0.5.6_linux_amd64.zip -o nomad.zip

echo Installing Nomad...
unzip nomad.zip
sudo chmod +x nomad
sudo mv nomad /usr/bin/nomad

sudo mkdir -p /etc/nomad.d
sudo chmod a+w /etc/nomad.d

SCRIPT

$scriptprom = <<SCRIPT
# Download Prometheus
echo Fetching Prometheus...
cd /tmp/
curl -sSL https://github.com/prometheus/prometheus/releases/download/v1.5.2/prometheus-1.5.2.linux-amd64.tar.gz -o prometheus.zip

echo Installing Prometheus...
tar -xzf prometheus.zip
cd prometheus-*
sudo chmod +x prometheus
sudo mv prometheus /usr/bin/prometheus

SCRIPT

$scriptprometheus = $scriptbase+$scriptprom
$scriptnomad = $scriptbase+$scriptnom

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64" # 16.04 LTS
#  config.vm.provision "docker" # Just install it

  # Increase memory for Virtualbox
  config.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
  end

  config.vm.define "nom1" do |nom1|
    nom1.vm.hostname = "nomad1"
    nom1.vm.network "private_network", ip: "192.168.7.77"
    nom1.vm.provision "shell" do |s|
      s.inline = $scriptnomad
      s.privileged = false
      s.args   = ["192.168.7.77", "3"]
    end
  end

  config.vm.define "nom2" do |nom2|
    nom2.vm.hostname = "nomad2"
    nom2.vm.network "private_network", ip: "192.168.7.78"
    nom2.vm.provision "shell" do |s|
      s.inline = $scriptnomad
      s.privileged = false
      s.args   = ["192.168.7.78", "3"]
    end
  end

  config.vm.define "nom3" do |nom3|
    nom3.vm.hostname = "nomad3"
    nom3.vm.network "private_network", ip: "192.168.7.79"
    nom3.vm.provision "shell" do |s|
      s.inline = $scriptnomad
      s.privileged = false
      s.args   = ["192.168.7.79", "3"]
    end
  end

  config.vm.define "prom" do |prom|
    prom.vm.hostname = "prometheus"
    prom.vm.network "private_network", ip: "192.168.7.80"
    prom.vm.provision "shell" do |s|
      s.inline = $scriptprometheus
      s.privileged = false
      s.args   = ["192.168.7.80"]
    end
  end

  config.vm.define "web" do |web|
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.7.81"
    web.vm.provision "shell" do |s|
      s.inline = $scriptbase
      s.privileged = false
      s.args   = ["192.168.7.81"]
    end
  end

end

