" Vim Keymap file for yiddish (phonetic)
" Maintainer  : James Waddington <sugarfrosted2005@gmail.com>
" Last Updated: Fri May  2 04:17:38 PDT 2014
" " This is a phonetic keyboard layout for yiddish with vowels marked. It is
" based on a yiddish phonetic key mapping for Yiddish located at:
" http://www.shoshke.net/uyip/qwerty_os_10.htm 
" download link: http://www.shoshke.net/uyip/Yiddish_QWERTYj.sit
" I have included some of the niqqad, these are the ones listed in Weinreich's
" College Yiddish textbook, they are here for completeness although they are
" seldom used.

let b:yiddish_cp1255="yidphonV"
highlight lCursor ctermbg=red guibg=red
loadkeymap
a   <char-224><char-199>    " אַ  pasekh alef
b   <char-225>              " ב  beyz
c   <char-246>              " צ  tsadek
d   <char-227>              " ד  daled
e   <char-242>              " ע  ayen
f   <char-244><char-207>    " פֿ  fey
g   <char-226>              " ג  giml
h   <char-228>              " ה  hey
i   <char-233>              " י  yud
j   <char-214>              " ײ  tsvey yudn
k   <char-247>              " ק  kuf
l   <char-236>              " ל  lamed
m   <char-238>              " מ  mem
n   <char-239>              " נ  nun
o   <char-224><char-200>    " אָ  komets alef
p   <char-244><char-204>    " פּ  pey
q   <char-235><char-204>    " כּ  kof
r   <char-248>              " ר  reysh
s   <char-241>              " ס  samekh
t   <char-232>              " ט  tes
u   <char-229>              " ו  vov
v   <char-212>              " װ  tsvey vovn
w   <char-249>              " ש  shin
x   <char-235>              " כ  khof
y   <char-214><char-119>    " ײַ  pasekh tsvey vovn
z   <char-230>              " ז  zayen
A   <char-224>              " א  shtumer alef
"B   <char-225><char-207>    " בֿ  veyz
C   <char-245>              " ץ  langer tsadek
"E   <char-214>              " ײ  tsvey yudn
F   <char-243>              " ף  langer fey
H   <char-228>              " ח  khes
I   <char-233><char-196>    " יִ  khirek yud
"K   <char-235><char-204>    " כּ  kof
M   <char-238>              " ם  shlos mem 
N   <char-239>              " ן  langer nun
"O   <char-224>              " א  shtumer alef
P   <char-244>              "  unpointed fey/pey
Qa  <char-199>              " ַ   pasekh
Qe  <char-198>              " ֶ   segol
Qi  <char-196>              " ִ   hirik
Qj  <char-197>              " ֵ   tsere
Qo  <char-200>              " ָ   komets
Qu  <char-203>              " ֻ   kubuts
QY  <char-201>              "  ֹ  kholem
S   <char-250>              " ת  sof
T   <char-250><char-204>    " תּ  tof
U   <char-229><char-204>    " וּ  melupm yud
V   <char-225><char-207>    " בֿ  veyz
W   <char-249><char-210>    " שׂ  sin
X   <char-234>              " ך  langer khof
Y   <char-213>              " ױ  vov yud
`   <char-206>              " ־  makef
