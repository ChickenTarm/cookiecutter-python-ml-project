FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu22.04

# change from /bin/sh to /bin/bash as the default shell
SHELL ["/bin/bash", "-c"]

RUN apt -y update; apt -y upgrade; \
    apt -y --no-install-recommends install software-properties-common; \
    add-apt-repository ppa:deadsnakes/ppa

ARG PYTHON_VERSION

# Install base ubuntu tools
RUN apt -y update; apt -y upgrade; apt -y --no-install-recommends install \
    screen \
    htop \
    wget \
    curl \
    git \
    git-core \
    zip \
    unzip \
    nano \
    $(echo "python$PYTHON_VERSION") \
    $(echo "python$PYTHON_VERSION-dev") \
    $(echo "python$PYTHON_VERSION-distutils") \
    python-is-python3 \
    ; apt -y autoremove; apt -y clean

RUN wget https://bootstrap.pypa.io/get-pip.py; \
    $(echo "python$PYTHON_VERSION") get-pip.py; \
    $(echo "python$PYTHON_VERSION") -m pip install --upgrade pip; \
    rm get-pip.py

RUN mkdir -p /home/{{cookiecutter.project_name}}
COPY poetry.lock pyproject.toml /home/{{cookiecutter.project_name}}/
WORKDIR /home/{{cookiecutter.project_name}}/
RUN pip install poetry; \
    poetry self add poetry-plugin-up; \
    poetry install; \
    poetry run poe pytorch

# need git to install pre-commit hooks can be done after docker build but this is more fool-proof
# If this is a docker image you will publish then this part should be removed. 
# This section is only so that the development experience is more natural: git commands from inside the container
COPY .git .git
RUN git config --global --add safe.directory /home/{{cookiecutter.project_name}}
COPY dev_configurations/.pre-commit-config.yaml /home/{{cookiecutter.project_name}}/dev_configuration
RUN poetry run pre-commit install -c /home/{{cookiecutter.project_name}}/dev_configurations/.pre-commit-config.yaml