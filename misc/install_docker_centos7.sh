sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

sudo yum install -y yum-utils

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo systemctl enable docker


# sudo docker pull ghcr.io/alexhanl/kuard:latest
# docker run -h $HOSTNAME --rm -p 8080:8080 -d ghcr.io/alexhanl/kuard

