#!/bin/bash

if ! command -v docker &> /dev/null
then
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

    curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | \
      sudo apt-key add -
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
      sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
    sudo apt-get update
    sudo apt-get install -y nvidia-container-runtime
    sudo tee /etc/docker/daemon.json <<EOF
    {
        "hosts": [
            "tcp://0.0.0.0:2375",
            "unix:///var/run/docker.sock"
        ],
        "runtimes": {
            "nvidia": {
                "path": "/usr/bin/nvidia-container-runtime",
                "runtimeArgs": []
            }
        },
        "default-runtime": "nvidia"
    }
EOF

    sudo mkdir -p /etc/systemd/system/docker.service.d
    sudo touch /etc/systemd/system/docker.service.d/override.conf
    sudo tee /etc/systemd/system/docker.service.d/override.conf <<EOF
    [Service]
    ExecStart=
    ExecStart=/usr/bin/dockerd
EOF
    sudo pkill -SIGHUP dockerd
    sudo systemctl enable docker
fi

sudo gpasswd -a $USER docker

if [ -d "/fiftyone/data/db" ]
then
    echo "There is an existing mongodb. If you want a fresh install please remove /fiftyone/data/db"
else
    sudo mkdir -p /fiftyone/data/db
    # Checks if mongo network exists if not creates it
    docker network inspect fiftyone-network >/dev/null 2>&1 || \
    docker network create --driver bridge fiftyone-network
    # Sets mongo to always be running this is done so that the database can be used across multiple projects
    sudo docker run -d --restart always --network fiftyone-network -e MONGO_INITDB_ROOT_USERNAME=root \
    -e MONGO_INITDB_ROOT_PASSWORD=password -v /fiftyone/data/db:/data/db \
    -p 27017:27017 --name mongo-container mongo:latest
    # Should change these if security is a concern or exposed to the internet
    echo -e "MONGO_USER=\"root\"\nMONGO_USER_PASSWORD=\"password\""| sudo tee -a /etc/environment
    echo "MONGO_IP=\"$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mongo-container)\"" | sudo tee -a /etc/environment
    source /etc/environment
fi