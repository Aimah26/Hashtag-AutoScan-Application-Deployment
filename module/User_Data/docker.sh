#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum update -y
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
sudo bash -c 'echo "
{
    "insecure-registries" : ["${var.nexus-ip}:8085"]
}" > /etc/docker/daemon.json'
sudo systemctl restart docker
echo "license_key: ${new_relic_key}" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y --nobest
sudo hostnamectl set-hostname Docker
