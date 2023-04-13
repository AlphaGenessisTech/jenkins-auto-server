  #!/bin/bash 
  sudo yum update -y
  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
  sudo yum upgrade -y
  sudo amazon-linux-extras install java-openjdk11 -y
  sudo yum install jenkins -y
   # Grand sudo access to jenkins user
  sudo echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins

  sudo yum install docker.io -y

  # 2. Enable PasswordAuthentication in the server
  sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
  sudo service sshd restart
  #
  sudo usermod -aG docker jenkins

  sudo hostname admin
  sudo su - jenkins
  sudo systemctl enable jenkins
  sudo systemctl start jenkins
  sudo systemctl status jenkins
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword