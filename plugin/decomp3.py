# -*- coding: utf-8 -*-
# from __future__ import print_function
from unicodedata import normalize
from sys import argv
from sys import stdout

if len(argv) < 2:
    char = None
else:
    char = argv[1]
    char = normalize('NFD', char)

print(char, end="")
