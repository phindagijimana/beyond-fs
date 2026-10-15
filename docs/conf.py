# beyond-fs documentation (Sphinx / Read the Docs), QSIPrep-style.
import os
import sys
from datetime import datetime

sys.path.insert(0, os.path.abspath(".."))

project = "beyond-fs"
author = "beyond-fs developers"
copyright = f"{datetime.now().year}, {author}"
version = "0.4.0"
release = version

extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.intersphinx",
    "sphinx.ext.todo",
    "sphinx.ext.viewcode",
    "sphinx.ext.githubpages",
]

templates_path = ["_templates"]
exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]
source_suffix = ".rst"
master_doc = "index"
language = "en"

html_theme = "sphinx_rtd_theme"
html_static_path = ["_static"]
html_title = "beyond-fs documentation"
html_short_title = "beyond-fs"
html_show_sphinx = False
html_theme_options = {
    "collapse_navigation": False,
    "navigation_depth": 3,
    "titles_only": False,
}

todo_include_todos = False
intersphinx_mapping = {
    "python": ("https://docs.python.org/3", None),
}
