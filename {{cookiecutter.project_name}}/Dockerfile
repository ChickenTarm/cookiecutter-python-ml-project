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

RUN curl -sSL https://install.python-poetry.org | $(echo "python$PYTHON_VERSION") -

RUN mkdir -p /home/{{cookiecutter.project_name}}
COPY poetry.lock pyproject.toml /home/{{cookiecutter.project_name}}/
WORKDIR /home/{{cookiecutter.project_name}}/
RUN pip install poetry; \
    poetry install; \
    poetry run poe force-pytorch