#!/usr/bin/env bash

rm /etc/motd
cat << EOF > /etc/motd
******************************************
Hello there! Welcome to your EC2 Instance.
******************************************

This instance is managed by: Kateryna Shyianova
This instance has Docker installed.

Best Practices:
- Keep it up to date with important information.
- Make sure to include contact details for support.
- Be mindful of system resources and usage.
- Follow security guidelines at all times.

Enjoy your work!
******************************************
EOF
yum install -y docker
usermod -aG docker ec2-user
systemctl enable docker
systemctl start docker
docker run -d --name nginx -p 8081:80 nginx:alpine
yum install -y https://s3.region.amazonaws.com/amazon-ssm-region/latest/linux_amd64/amazon-ssm-agent.rpm #Встановлення SSM Agent
