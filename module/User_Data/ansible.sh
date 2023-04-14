#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum update -y
sudo yum install python3-pip -y
sudo -E pip3 install pexpect
sudo pip3 install boto boto3 botocore 
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo yum update -y 
sudo yum install git python python-devel python-pip ansible -y
sudo touch /etc/ansible/stage_hosts
sudo echo "[STAGE_Server]" >> /etc/ansible/stage_hosts
sudo chown ec2-user:ec2-user /etc/ansible/hosts
sudo chown -R ec2-user:ec2-user /etc/ansible && chmod +x /etc/ansible
sudo chmod 777 /etc/ansible/hosts
sudo chmod 777 /etc/ansible/stage_hosts
sudo echo "[PROD_Server]" >> /etc/ansible/hosts
sudo bash -c 'echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
mkdir /home/ec2-user/playbooks
touch /home/ec2-user/playbooks/STAGEConsoleIP.yml
touch /home/ec2-user/playbooks/PRODConsoleIP.yml
echo "${file(vault_password)}" >> /home/ec2-user/playbooks/vault_password.yml
sudo chmod 666 /home/ec2-user/playbooks/STAGEConsoleIP.yml
sudo chmod 666 /home/ec2-user/playbooks/PRODConsoleIP.yml
echo "admin" >> /home/ec2-user/playbooks/pass
echo "${file(STAGEcontainer)}" >> /home/ec2-user/playbooks/STAGEcontainer.yml
echo "${file(PRODcontainer)}" >> /home/ec2-user/playbooks/PRODcontainer.yml  
echo "${file(PROD_Auto_Discovery)}" >> /home/ec2-user/playbooks/PROD_Auto_Discovery.yml
echo "${file(PROD_runner)}" >> /home/ec2-user/playbooks/PROD_runner.yml
echo "${file(stage_auto_discovery)}" >> /home/ec2-user/playbooks/stage_auto_discovery.yml
echo "${file(stage_runner)}" >> /home/ec2-user/playbooks/stage_runner.yml
echo "$(ansible-vault encrypt_string  ${doc_pass} --name docker_password --vault-pass-file /home/ec2-user/playbooks/pass)" >> /home/ec2-user/playbooks/vault_cred.yml 
echo "$(ansible-vault encrypt_string  ${doc_user} --name docker_username --vault-pass-file /home/ec2-user/playbooks/pass)" >> /home/ec2-user/playbooks/vault_cred.yml 
sudo chown -R ec2-user:ec2-user /home/ec2-user/playbooks/
echo "license_key: ${new_relic_key}" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y --nobest
echo "${file(keypair)}" >> /home/ec2-user/Hashkey
sudo chown ec2-user:ec2-user /home/ec2-user/Hashkey
chmod 400 /home/ec2-user/Hashkey
sudo hostnamectl set-hostname ansible
sudo su -c "ansible-playbook -i /etc/ansible/stage_hosts /home/ec2-user/playbooks/stage_runner.yml" ec2-user 
sudo su -c "ansible-playbook -i /etc/ansible/hosts /home/ec2-user/playbooks/PROD_runner.yml" ec2-user 
