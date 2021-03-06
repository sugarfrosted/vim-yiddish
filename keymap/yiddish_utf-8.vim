" Vim Keymap file for yiddish (phonetic)
" Maintainer  : James Waddington <sugarfrosted2005@gmail.com>
" Last Updated: Mon 13 Jan 2014 01:56:49
" This is a phonetic keyboard layout for yiddish with vowels marked. It is
" based on a yiddish phonetic key mapping for Yiddish located at:
" http://www.shoshke.net/uyip/qwerty_os_10.htm 
" download link: http://www.shoshke.net/uyip/Yiddish_QWERTYj.sit
" I have included some of the niqqad, these are the ones listed in Weinreich's
" College Yiddish textbook, they are here for completeness although they are
" seldom used.

let b:yiddish_utf8="yidphon"
highlight lCursor ctermbg=red guibg=red
loadkeymap
a   <char-0x5d0><char-0x5b7>    " אַ  pasekh alef
b   <char-0x5d1>                " ב  beyz
c   <char-0x5e6>                " צ  tsadek
d   <char-0x5d3>                " ד  daled
e   <char-0x5e2>                " ע  ayen
f   <char-0x5e4><char-0x5bf>    " פֿ  fey
g   <char-0x5d2>                " ג  giml
h   <char-0x5d4>                " ה  hey
i   <char-0x5d9>                " י  yud
j   <char-0x5f2>                " ײ  tsvey yudn
k   <char-0x5e7>                " ק  kuf
l   <char-0x5dc>                " ל  lamed
m   <char-0x5de>                " מ  mem
n   <char-0x5e0>                " נ  nun
o   <char-0x5d0><char-0x5b8>    " אָ  komets alef
p   <char-0x5e4><char-0x5bc>    " פּ  pey
q   <char-0x5db><char-0x5bc>    " כּ  kof
r   <char-0x5e8>                " ר  reysh
s   <char-0x5e1>                " ס  samekh
t   <char-0x5d8>                " ט  tes
u   <char-0x5d5>                " ו  vov
v   <char-0x5f0>                " װ  tsvey vovn
w   <char-0x5e9>                " ש  shin
x   <char-0x5db>                " כ  khof
y   <char-0x5f2><char-0x5b7>    " ײַ  pasekh tsvey vovn
z   <char-0x5d6>                " ז  zayen
A   <char-0x5d0>                " א  shtumer alef
C   <char-0x5e5>                " ץ  langer tsadek
F   <char-0x5e3>                " ף  langer fey
H   <char-0x5d7>                " ח  khes
I   <char-0x5d9><char-0x5b4>    " יִ  khirek yud
M   <char-0x5dd>                " ם  shlos mem 
N   <char-0x5df>                " ן  langer nun
P   <char-0x5e4>                "  unpointed fey/pey
Qa  <char-0x5b7>                " ַ   pasekh
Qe  <char-0x5c6>                " ֶ   segol
Qi  <char-0x5b4>                " ִ   hirik
Qj  <char-0x5b5>                " ֵ   tsere
Qo  <char-0x5b8>                " ָ   komets
Qu  <char-0x5bb>                " ֻ   kubuts
QY  <char-0x5b9>                "  ֹ  kholem
S   <char-0x5ea>                " ת  sof
T   <char-0x5ea><char-0x5bc>    " תּ  tof
U   <char-0x5d5><char-0x5bc>    " וּ  melupm yud
V   <char-0x5d1><char-0x5bf>    " בֿ  veyz
W   <char-0x5e9><char-0x5c2>    " שׂ  sin
X   <char-0x5da>                " ך  langer khof
Y   <char-0x5f1>                " ױ  vov yud
`   <char-0x5be>                " ־  makef
~   <char-0x5f4>                " gershayim
