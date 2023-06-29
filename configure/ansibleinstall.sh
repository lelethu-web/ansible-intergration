#!/bin/bash
  sudo apt update -y
  sudo apt install -y software-properties-common
  sudo add-apt-repository --yes --update ppa:ansible/ansible
  sudo apt install -y ansible
  sudo ansible-config init --disabled -t all > /etc/ansible/ansible.cfg
  sudo mkdir -p /etc/ansible/roles/nginx
  sudo mkdir -p /etc/ansible/roles/nginx/tasks
  sudo mkdir -p /etc/ansible/roles/virtualhost
  sudo mkdir -p /etc/ansible/roles/virtualhost/tasks
  sudo chmod go+x /tmp/configure/virtualprep.sh
  sudo chmod go+x /tmp/configure/final.sh
  sudo mv  /tmp/configure/final.sh      /etc/ansible/
  sudo mv  /tmp/configure/nginxtask.yaml  /etc/ansible/roles/nginx/tasks/main.yaml
  sudo mv  /tmp/configure/playbook.yaml   /etc/ansible/
  sudo mv  /tmp/configure/virtualprep.sh   /etc/ansible/
  sudo mv  /tmp/configure/virtualtask.yaml   /etc/ansible/roles/virtualhost/tasks/main.yaml
   ssh-keygen -q -t rsa -N '' -f /home/ubuntu/.ssh/ubuntu <<<y >/dev/null 2>&1 
  sudo cat /home/ubuntu/.ssh/ubuntu.pub | echo -e  >>  ~/.ssh/authorized_keys
  sudo cat /home/ubuntu/.ssh/ubuntu.pub  >>  ~/.ssh/authorized_keys
  sudo touch /etc/ansible/inv && sudo chmod go+w /etc/ansible/inv
   sudo apt install -y ansible
  sudo ansible-config init --disabled -t all > /etc/ansible/ansible.cfg
  sudo echo -e 'localhost ansible_connection=local' > /etc/ansible/inv
  cd /etc/ansible
  sudo  /etc/ansible/final.sh