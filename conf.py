# -*- coding: utf-8 -*-
#
# Configuration file for the Sphinx documentation builder.
#
# This file does only contain a selection of the most common options. For a
# full list see the documentation:
# http://www.sphinx-doc.org/en/stable/config

import sys, os

import otcdocstheme

extensions = [
    'sphinx.ext.autodoc',
    'otcdocstheme',
    'sphinx.ext.viewcode',
]

# -- Project information -----------------------------------------------------

project = u'MCSPS Release Notes'
copyright = u'2020, Frank Kloeker'
author = u'Frank Kloeker'

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
#
source_parsers = {
   '.md': 'recommonmark.parser.CommonMarkParser',
}

source_suffix = ['.rst', '.md' ]

# The master toctree document.
master_doc = 'index'

language = None
exclude_patterns = []
pygments_style = 'sphinx'

#html_theme = 'otcdocs'
html_theme = 'classic'
html_theme_options = {
    'footerbgcolor': '#ffffff',
    'footertextcolor': '#e5007d',
    'sidebarbgcolor': '#e5007d',
    'sidebarbtncolor': '#ededed',
    'sidebartextcolor': '#eeeeee',
    'sidebarlinkcolor': '#000000',
    'relbarbgcolor': '#d0d0d0',
    'relbartextcolor': '#a20074',
    'relbarlinkcolor': '#a80257',
    'bgcolor': '#ffffff',
    'textcolor': '#6c6c6c',
    'linkcolor': '#4b4b4b',
    'visitedlinkcolor': '#6c6c6c',
#    'headbgcolor':
#    'headtextcolor':
#    'headlinkcolor':
    'codebgcolor': '#ededed',
    'codetextcolor': '#a4a4a4',
    'bodyfont': 'Tele-GroteskNor',
    'headfont': 'Tele-GroteskFet',
}
html_static_path = ['_static']
html_extra_path = ['_images']
htmlhelp_basename = 'MCSPS Release Notes'

texinfo_documents = [
    (master_doc, 'Blogs as code', u'MCSPS Release Notes Documentation',
     author, 'Blogs as code', 'One line description of project.',
     'Miscellaneous'),
]

# gettext_compact = False     # optional.
