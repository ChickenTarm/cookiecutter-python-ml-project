# cookiecutter-python-ml-project

<!-- badges-begin -->

[![License][license badge]][license]<br>
[![Read the documentation][readthedocs badge]][readthedocs page]
[![pre-commit enabled][pre-commit badge]][pre-commit project]
[![Black codestyle][black badge]][black project]
[![Contributor Covenant][contributor covenant badge]][code of conduct]

[black badge]: https://img.shields.io/badge/code%20style-black-000000.svg
[black project]: https://github.com/psf/black
[calver badge]: https://img.shields.io/badge/calver-YYYY.MM.DD-22bfda.svg
[code of conduct]: https://github.com/ChickenTarm/my-ml-python-cookiecutter/blob/main/CODE_OF_CONDUCT.md
[contributor covenant badge]: https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg
[github actions badge]: https://github.com/ChickenTarm/my-ml-python-cookiecutter/workflows/Tests/badge.svg
[github page]: https://github.com/ChickenTarm/my-ml-python-cookiecutter
[license badge]: https://img.shields.io/github/license/ChickenTarm/cookiecutter-python-ml-project
[license]: https://opensource.org/licenses/MIT
[pre-commit badge]: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
[pre-commit project]: https://pre-commit.com/
[readthedocs badge]: https://img.shields.io/readthedocs/cookiecutter-hypermodern-python/latest.svg?label=Read%20the%20Docs
[readthedocs page]: https://cookiecutter-hypermodern-python.readthedocs.io/


<!-- badges-end -->
<p align="center">
<img src="https://miro.medium.com/v2/resize:fit:4800/format:webp/0*rLqrYHetoNXlt5xI.png"  width="50%" height="50%">
</p>

A [Cookiecutter] template for ML Python package based on the [Automatic ML Project Setup] article.

This is designed with reproducibility, distribution, and easy data wrangling and exploration in mind. Many different ml repos have differing: data structures, training loops, visualizations, and deployment.

 - [fiftyone] is used to ensure standardization of formats. Many different datasets for the same task have different formats. Fiftyone fixes this since it has built many integrations for importing and exporting data. This makes data loading, and visualization much easier.
 - [lightning] is used to put structure to machine learning code. It has a standard control flow where it is easy to learn. Lightning also has many integrations and abstractions that make training much more efficient and scalable.
 - [wandb] is used to help visualize the actual training process. It allows for powerful and custom visualization needs and experiment comparison.
 - Lastly, environment management is one of the biggest issues with ml. Too many machine learning repos do not have a [docker] container which makes cloning and using the project more difficult. Everything should be ran in containers unless there is a specific reason not to.


[cookiecutter]: https://github.com/audreyr/cookiecutter
[automatic ml project setup]: https://medium.com/voxel51/automatically-set-up-a-new-ml-project-pain-free-voxel51-1b900daaaf77
[hypermodern python cookiecutter]: https://github.com/cjolowicz/cookiecutter-hypermodern-python

## Usage

```console
$ cookiecutter https://github.com/ChickenTarm/cookiecutter-python-ml-project.git
```

## Features

<!-- features-begin -->

- Containerization and templated deployment services with [Docker]
- Data management and visualization with [fiftyone] and [mongodb]
- Packaging and dependency management with [Poetry]
- Test automation with [Nox]
- Linting with [pre-commit] and [Flake8]
- Continuous integration with [GitHub Actions]
- Documentation with [Sphinx], [MyST], and [Read the Docs] using the [furo] theme
- Automated uploads to [PyPI] and [TestPyPI]
- Automated dependency updates with [Dependabot]
- Code formatting with [Black] and [Prettier]
- Import sorting with [isort]
- Testing with [pytest]
- Code coverage with [Coverage.py]
- Coverage reporting with [Codecov]
- Command-line interface with [Click]
- Static type-checking with [mypy]
- Runtime type-checking with [Typeguard]
- Automated Python syntax upgrades with [pyupgrade]
- Security audit with [Bandit] and [Safety]
- Check documentation examples with [xdoctest]
- Generate API documentation with [autodoc] and [napoleon]
- Generate command-line reference with [sphinx-click]

The template supports Python 3.7, 3.8, 3.9, and 3.10.


[autodoc]: https://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html
[bandit]: https://github.com/PyCQA/bandit
[black]: https://github.com/psf/black
[click]: https://click.palletsprojects.com/
[codecov]: https://codecov.io/
[coverage.py]: https://coverage.readthedocs.io/
[dependabot]: https://dependabot.com/
[docker]: https://www.docker.com
[fiftyone]: https://github.com/voxel51/fiftyone
[flake8]: http://flake8.pycqa.org
[furo]: https://pradyunsg.me/furo/
[github actions]: https://github.com/features/actions
[github labeler]: https://github.com/marketplace/actions/github-labeler
[isort]: https://pycqa.github.io/isort/
[lightning]: https://www.pytorchlightning.ai
[mongodb]: https://github.com/mongodb/mongo
[mypy]: http://mypy-lang.org/
[myst]: https://myst-parser.readthedocs.io/
[napoleon]: https://www.sphinx-doc.org/en/master/usage/extensions/napoleon.html
[nox]: https://nox.thea.codes/
[poetry]: https://python-poetry.org/
[pre-commit]: https://pre-commit.com/
[prettier]: https://prettier.io/
[pypi]: https://pypi.org/
[pytest]: https://docs.pytest.org/en/latest/
[pyupgrade]: https://github.com/asottile/pyupgrade
[read the docs]: https://readthedocs.org/
[release drafter]: https://github.com/release-drafter/release-drafter
[safety]: https://github.com/pyupio/safety
[sphinx]: http://www.sphinx-doc.org/
[sphinx-click]: https://sphinx-click.readthedocs.io/
[testpypi]: https://test.pypi.org/
[typeguard]: https://github.com/agronholm/typeguard
[wandb]: https://wandb.ai/site
[xdoctest]: https://github.com/Erotemic/xdoctest

<!-- features-end -->
