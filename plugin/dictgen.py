# -*- coding: utf-8 -*-
from unicodedata import normalize
from re import sub

butts="אַאָוּיִפּפֿתּכּשׂײַבֿ"
dickptn = "{"
dickntp = "{"
for butt in butts:
    dickptn += '"' + butt + '" : "' + normalize('NFD', butt) + '",'
    dickntp += '"' + normalize('NFD', butt) + '" : "' + butt + '",'

dickntp = "let g:yidnoncomp2precomp = " + dickntp 
dickptn = "let g:yidprecomp2noncomp = " + dickptn 
print(sub(r",$","}",dickntp))
print(sub(r",$","}",dickptn))
