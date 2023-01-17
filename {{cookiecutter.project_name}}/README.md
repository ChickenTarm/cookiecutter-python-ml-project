# {{ cookiecutter.friendly_name }}

[![Python Version](https://img.shields.io/badge/python-3.10-blue)][pypi status]
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)][pre-commit]
[![poetry](https://img.shields.io/badge/package%20manager-poetry-blue)][poetry]

[![sphinx](https://img.shields.io/badge/docs-sphinx-blue)][sphinx]
[![Black](https://img.shields.io/badge/code%20style-black-000000.svg)][black]
[![Pyright](https://img.shields.io/badge/type%20checker-pyright-blue.svg)][pyright]

[pypi status]: https://pypi.org/project/{{cookiecutter.project_name}}/
[poetry]: https://github.com/python-poetry/poetry
[pre-commit]: https://github.com/pre-commit/pre-commit
[sphinx]: https://github.com/sphinx-doc/sphinx
[black]: https://github.com/psf/black
[pyright]: https://github.com/microsoft/pyright

## Requirement

This has only been tested on Ubuntu 22.04


## Installation

```
./scripts/setup_host.env
docker compose --env-file /etc/environment up -d --build
```

```
./scripts/setup_host.env
```
This will check if docker is installed, if not then it will install docker along with the compose plugin for docker and the container runtime for nvidia hardware. It will also set the default configuration of docker to use nvidia as the default runtime. This will enable access to nvidia hardware during the build process of a Dockerfile and not just on run.


The script will also check for and automatically create a docker network for mongodb so that a future cookiecutter project using this template is able to connect to and utilize mongodb which is storing the data for fiftyone. This will help centralize the source of truth for data and reduce multiple copies of large datasets like COCO. Then the monogdb container is started up on that network and the IP of the database is fetched and stored in /etc/environment so all applications will be able to find it. The data is stored at /fiftyone/data/db to make backups easier. When doing an upgrade, it makes for easier backing up and exporting of the data. 

```
docker compose --env-file /etc/environment up -d --build
```

This will build your development environment. It copies in the poetry.lock and pyproject.toml which will check for changes in the environment. It will build and install all the packages you have defined. 


After the image is built the container is attached to the mongo docker network, and the environment variables that fiftyone needs to access mongo are passed in. 

The default command for the container allows it to run indefinitely. This is to allow for a long running container so VSCode can attach to it along with the useful debugging tools. VSCode is not the only IDE that can connect to a docker container, but it is the best IDE that I have seen in doing that.


## Tests

To run all tests:

`
nox --session tests
`

If you want to run a specific file to debug it:

`
pytest <path to the file>
`

## Pre-commit

Install:

`
pre-commit install dev_configurations/.pre-commit-config.yaml
`

Running it on existing files
`
nox --session pre-commit
`

### Adding new pre-commit hooks
pre-commit has the ability to use local installation of programs for the hooks, but the git repo along with the release or commit version is the better method.


## Documentation

To build documentation for the code:
`
nox --session docs-build
`

## CI
The CI is located at .gitlab-ci.yml

The tests in the ci will run and produce an artifact that will be used for test report via allure.

The results should be viewable throught Settings -> Pages

## Poetry
### Adding a package
Pip:

`
pip install <package1> <package2>
`

Poetry:

`
poetry add <package1> <package2>
`

To add a package that is only used for development purposes:

`
poetry add -D <package1> <package2>
`
### Remove a package
Pip:

`
pip uninstall <package1> <package2>
`

Poetry:

`
poetry remove <package1> <package2>
`

To remove a package that is only used for development purposes:

`
poetry remove -D <package1> <package2>
`
### Installing dependencies from a file
Pip:

`
pip install -r requirements.txt
`

Poetry

`
poetry install
`

To install non-development dependencies

`
poetry install --no-dev
`
