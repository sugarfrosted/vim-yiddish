# -*- coding: utf-8 -*-
from unicodedata import normalize
from re import sub
from sys import argv

if len(argv) < 3:
    butts = list("אַאָוּיִפּפֿתּכּשׂײַבֿ".decode('utf-8'))
    name = "yid"
else:
    butts = list(argv[1])
    name = argv[2]

dictionaryptn = "{"
dictionaryntp = "{"
for butt in butts:
    dictionaryptn += '"' + butt + '" : "' + normalize('NFD', butt) + '",'
    dictionaryntp += '"' + normalize('NFD', butt) + '" : "' + butt + '",'

dictionaryntp = "let g:" + name + "noncomp2precomp = " + dictionaryntp
dictionaryptn = "let g:" + name + "precomp2noncomp = " + dictionaryptn

print(sub(r",$", "}", dictionaryntp))
print(sub(r",$", "}", dictionaryptn))
