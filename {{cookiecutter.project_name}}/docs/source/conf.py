import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'src'))
"""Sphinx configuration."""
project = "{{cookiecutter.friendly_name}}"
author = "{{cookiecutter.author}}"
copyright = "{{cookiecutter.copyright_year}}, {{cookiecutter.author}}"
extensions = [
    "sphinx.ext.autodoc",
    'sphinx.ext.autosummary',
    "sphinx.ext.napoleon",
    "sphinx_click",
]
autosummary_generate = True
autosummary_imported_members = True
autodoc_typehints = "description"
html_theme = "furo"
