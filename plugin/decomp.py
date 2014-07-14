# -*- coding: utf-8 -*-
from __future__ import print_function
from unicodedata import normalize
from sys import argv
from sys import version_info

if len(argv) < 2:
    char = ""
char = argv[1].decode('utf-8')
print_function(normalize('NFD', char), end = '')
