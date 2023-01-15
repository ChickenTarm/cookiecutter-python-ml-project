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
