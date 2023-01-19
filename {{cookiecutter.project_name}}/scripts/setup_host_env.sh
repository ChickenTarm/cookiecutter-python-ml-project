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
    # Checks if ml-network exists if not creates it
    docker network inspect ml-network >/dev/null 2>&1 || \
    docker network create --driver bridge ml-network
    # Sets mongo to always be running this is done so that the database can be used across multiple projects
    sudo docker run -d --restart always --network ml-network -e MONGO_INITDB_ROOT_USERNAME=root \
    -e MONGO_INITDB_ROOT_PASSWORD=password -v /fiftyone/data/db:/data/db \
    -p 27017:27017 --name mongo-container mongo:latest
    # Should change these if security is a concern or exposed to the internet
    echo -e "MONGO_USER=\"root\"\nMONGO_USER_PASSWORD=\"password\""| sudo tee -a /etc/environment
    echo "MONGO_IP=\"$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mongo-container)\"" | sudo tee -a /etc/environment
    source /etc/environment
fi

if [ -d "/qdrant/storage" ]
then
    echo "There is an existing qdrant db. If you want a fresh install please remove /qdrant/storage"
else
    sudo mkdir -p /qdrant/storage
    # Checks if ml-network exists if not creates it
    docker network inspect ml-network >/dev/null 2>&1 || \
    docker network create --driver bridge ml-network
    # Sets qdrant to always be running this is done so that the database can be used across multiple projects
    sudo docker run -d --restart always --network ml-network -v /qdrant/storage:/qdrant/storage \
    -p 6333:6333 -p 6334:6334 --name qdrant-container qdrant/qdrant:latest
    echo "QDRANT_IP=\"$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' qdrant-container)\"" | sudo tee -a /etc/environment
    source /etc/environment
fi