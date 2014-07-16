# -*- coding: utf-8 -*-
#from __future__ import print_function
from unicodedata import normalize
from sys import argv
from sys import version_info
from sys import stdout
import os

if len(argv) < 2:
    char = None
else:
    char = argv[1].decode('utf-8')
    char = normalize('NFD', char)
    
stdout.write(char.encode('utf-8'))
