# -*- coding: utf-8 -*-
#from __future__ import print_function
from unicodedata import normalize
from sys import argv
from sys import version_info
from sys import stdout

if len(argv) < 2:
    char = ""
char = argv[1].decode('utf-8')
stdout.write(normalize('NFD', char))
