let g:defaultdecompchars = ["אַ", "אָ", "כּ", "פּ", "פֿ", "בֿ", "תּ", "יִ", "וּ", "ײַ", "שׂ"]
sort(g:defaultdecompchars)
let g:defaultdecompchars=filter(copy(g:defaultdecompchars), 'index(g:defaultdecompchars, v:val, v:key+1)==-1')
lockvar g:defaultdecompchars
if !exists("g:decompchars")
    let g:decompchars = g:defaultdecompchars
endif
function! YiddishShortCuts()
"    if exists("g:OldYiddishKeys")
"        if type(g:OldYiddishKeys) == type("")
"            for mapping in g:OldYiddishKeys
"                execute "nunmap " . mapping . " :Yidkey<Enter>"
"            endfor
"        elseif type(g:OldYiddishKeys) == type([])
"            for mapping in g:OldYiddishKeys
"                execute "nunmap " . mapping . " :Yidkey<Enter>"
"            endfor
"        endif
"    endif
    if !exists("g:YiddishKeys")
        let g:YiddishKeys = ["t","T"]
    endif
    if type(g:YiddishKeys) == type("")
        let mapping = g:YiddishKeys
        execute "nnoremap " . mapping . " :Yidkey<Enter>"
    else
        if type(g:YiddishKeys) != type([])
            let g:YiddishKeys = ["t","T"]
        endif
        for mapping in g:YiddishKeys
            execute "nnoremap " . mapping . " :Yidkey<Enter>"
        endfor
    endif
"    let g:OldYiddishKeys = g:YiddishKeys
    noremap <Leader>tran :CompTransSel<Enter>
    noremap <Leader>tral :CompTransAll<Enter>
    inoremap <F8> <c-\><c-O>:Yidkey<Enter>
endfunction

command YiddishSC :call YiddishShortCuts()
if &encoding == 'utf-8'
    if !exists("g:precomposed")
        let g:precomposed=1
    endif
else
    let g:precomposed=0
endif
function! Composure()
    if encoding == 'utf-8'
        if g:precomposed
            let g:precomposed=0
            iabbrev כּ כּ
            iabbrev ײַ ײַ
            iabbrev אָ אָ
            iabbrev אַ אַ
            iabbrev פּ פּ
            iabbrev פֿ פֿ
            iabbrev שׂ שׂ
            iabbrev וּ וּ
            iabbrev יִ יִ
            iabbrev תּ תּ
            iabbrev בֿ בֿ
            echo "Not Precomposed"
        else
            let g:precomposed=1
            iunabbrev כּ
            iunabbrev ײַ
            iunabbrev אָ
            iunabbrev אַ
            iunabbrev פּ
            iunabbrev פֿ
            iunabbrev שׂ
            iunabbrev וּ
            iunabbrev יִ
            iunabbrev תּ
            iunabbrev בֿ
            echo "Precomposed"
        endif
    else
        echo "Encoding lacks precomposed varaints"
    endif
endfunction

function! YiddishKeyBoard()
    if !exists("w:yidl") "sets default value for w:yidl if not yet set
        let w:yidl=0 "assumed initial value
    endif
    if w:yidl "turns off yiddish mode and switches back to english
        set spelllang=en_us
        set norightleft
        set keymap=""
        set norevins
        let w:yidl = 0
        echo "English"
        unmap \|
    else
        set keymap=yiddishprecomp
        if g:precomposed
            set spelllang=yi-pc
            echo "Precomposed Yiddish"
        else
            set spelllang=yi
            echo "Non-Precomposed Yiddish"
        endif
        if &termbidi "experimental and hackeryish
            nnoremap h l
            nnoremap l h
            inoremap <left> <right>
            inoremap <right> <left>
        else
            set rightleft
        endif
        let w:yidl=1
        noremap \| :Precomp<Enter>
    endif
endfunction

if has("python") 
python << endpython
# -*- coding: utf-8 -*-
import vim
from unicodedata import normalize
vim.vars["yidnoncomp2precomp"] = {}
vim.vars["yidprecomp2noncomp"] = {}
for char in vim.vars["decompchars"]:
    charhold = char.decode('utf-8')
    vim.vars["yidnoncomp2precomp"][normalize('NFD',charhold)] = charhold
    vim.vars["yidprecomp2noncomp"][charhold] = normalize('NFD',charhold)
endpython
elseif has("python3")
python3 << endpython3
# -*- coding: utf-8 -*-
import vim
from unicodedata import normalize
vim.vars["yidnoncomp2precomp"] = {}
vim.vars["yidprecomp2noncomp"] = {}
for char in vim.vars["decompchars"]:
    vim.vars["yidnoncomp2precomp"][normalize('NFD',char)] = char
    vim.vars["yidprecomp2noncomp"][char] = normalize('NFD',char)
endpython3
else
    if !exists("g:python27location")
        let g:python27location = "python2.7"
    endif
    let g:yidnoncomp2precomp = {"אַ" : "אַ","אָ" : "אָ","וּ" : "וּ","יִ" : "יִ","פּ" : "פּ","פֿ" : "פֿ","תּ" : "תּ","כּ" : "כּ","שׂ" : "שׂ","ײַ" : "ײַ","בֿ" : "בֿ"}
    let g:yidprecomp2noncomp = {"אַ" : "אַ","אָ" : "אָ","וּ" : "וּ","יִ" : "יִ","פּ" : "פּ","פֿ" : "פֿ","תּ" : "תּ","כּ" : "כּ","שׂ" : "שׂ","ײַ" : "ײַ","בֿ" : "בֿ"}
    if g:decompchars != g:defaultdecompchars
        if executable("python2.7")
            let g:yidnoncomp2precomp = {}
            let g:yidprecomp2noncomp = {}
            for char in decompchars
                let dechar = system("python2.7 " . "decomp.py " . char)
                "for testing
                let g:yidprecomp2noncomp[char] = dechar
                let g:yidnoncomp2precomp[dechar] = char
            endfor
        else
            echo "python2.7 is required, if it has a different name you need to specify it in your .vimrc function with `let g:python27location = `. Using newer versions of python2.6 (with import from __future__) might work but it isn't supported."
        endif
    endif
endif

function! RegexThing() range
    if encoding == 'utf-8'
        let ranger = a:firstline . "," . a:lastline
        if g:precomposed
            let direction = "precomposed"
            let dictat = g:yidnoncomp2precomp
        else
            let direction = "decomposed"
            let dictat = g:yidprecomp2noncomp
        endif
        for char in keys(dictat) "shit fix this I on't care right now
            execute ranger . "s/" . char . "/" . dictat[char] . "/ge"        
        endfor
        echo "Characters now " . direction
    else
        echo "Encoding lacks precomposed variants"
    endif
endfunction


command Yidkey :call YiddishKeyBoard()
command Precomp :call Composure()
command -range=% CompTransAll :call RegexThing()
command -range CompTransSel :call RegexThing()
if !exists("g:YiddishEnabled")
    let g:YiddishEnabled = 0
endif
if g:YiddishEnabled
    autocmd VimEnter * :call YiddishShortCuts()
endif
