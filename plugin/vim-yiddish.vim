if !exists("g:debugwithPY")
    let g:debugwithPY = 1
endif
let g:defaultdecompchars = ["אַ", "אָ", "כּ", "פּ", "פֿ", "בֿ", "תּ", "יִ", "וּ", "ײַ", "שׂ"]
sort(g:defaultdecompchars)
let g:defaultdecompchars=filter(copy(g:defaultdecompchars), 'index(g:defaultdecompchars, v:val, v:key+1)==-1')
lockvar g:defaultdecompchars
let g:defaultyidnoncomp2precomp = {"אַ" : "אַ","אָ" : "אָ","וּ" : "וּ","יִ" : "יִ",
            \"פּ" : "פּ","פֿ" : "פֿ","תּ" : "תּ","כּ" : "כּ","שׂ" : "שׂ","ײַ" : "ײַ",
            \"בֿ" : "בֿ"}
let g:defaultyidprecomp2noncomp = {"אַ" : "אַ","אָ" : "אָ","וּ" : "וּ","יִ" : "יִ",
            \"פּ" : "פּ","פֿ" : "פֿ","תּ" : "תּ","כּ" : "כּ","שׂ" : "שׂ","ײַ" : "ײַ",
            \"בֿ" : "בֿ"}
lockvar g:defaultyidnoncomp2precomp
lockvar g:defaultyidprecomp2noncomp
if !exists("g:decompchars")
    let g:decompchars = g:defaultdecompchars
    let g:yidnoncomp2precomp = g:defaultyidnoncomp2precomp
    let g:yidprecomp2noncomp = g:defaultyidprecomp2noncomp
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
    if &encoding == 'utf-8'
        let dictat = g:yidprecomp2noncomp
        if g:precomposed
            let g:precomposed=0
            for char in keys(dictat)
                execute "iabbrev " . char . " " . dictat[char] 
            endfor
            echo "Not Precomposed"
        else
            let g:precomposed=1
            for char in keys(dictat)
                execute "iunabbrev " . dictat[char]
            endfor
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

if g:decompchars != g:defaultdecompchars

"disabled.
if has("python3") && 0 
python3 << endpython3
import vim
from unicodedata import normalize
vim.vars["yidnoncomp2precomp"] = {}
vim.vars["yidprecomp2noncomp"] = {}
for char in vim.vars["decompchars"]:
    vim.vars["yidnoncomp2precomp"][normalize('NFD',char)] = char
    vim.vars["yidprecomp2noncomp"][char] = normalize('NFD',char)
endpython3

elseif has("python")&& g:debugwithPY 
python << endpython
import vim
from unicodedata import normalize
vim.vars["yidnoncomp2precomp"] = {}
vim.vars["yidprecomp2noncomp"] = {}
for char in vim.vars["decompchars"]:
    charhold = char.decode('utf-8')
    vim.vars["yidnoncomp2precomp"][normalize('NFD',charhold)] = charhold
    vim.vars["yidprecomp2noncomp"][charhold] = normalize('NFD',charhold)
endpython
else
    "let g:python27location = "jdiohadsiuhfiuhewiuhqf"
    "testing here
    if !exists("g:python27location")
        let g:python27location = "python2.7"
    endif
"    let g:YidPythonVersion = system("Python -V")
"    let g:YidPythonVersion = split(g:YidPythonVersion)[1]
"    let g:YidPythonVersion = split(g:YidPythonVersion, '.')
"    let g:My_Test = g:YidPythonVersion
"    if g:YidPythonVersion >= ["3","0","0"]:
"        let scriptplace = s:path . "/decomp3.py"
"    elseif g:YidPythonVersion >= ["2","6","0"]
"        let scriptplace = s:path . "/decomp.py"
"    endif
        if executable("uconv")
            let g:yidnoncomp2precomp = {}
            let g:yidprecomp2noncomp = {}
            for char in g:decompchars
                let dechar = system("uconv -x any-nfd <<<" . char)
                let dechar = substitute(dechar,"\n","","ge") 
                let g:yidprecomp2noncomp[char] = dechar
                let g:yidnoncomp2precomp[dechar] = char
            endfor
        elseif executable(g:python27location)
            let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
            let g:yidnoncomp2precomp = {}
            let g:yidprecomp2noncomp = {}
            for char in g:decompchars
                let dechar = system(g:python27location . " " . s:path . "/decomp.py " . char)
                let g:yidprecomp2noncomp[char] = dechar
                let g:yidnoncomp2precomp[dechar] = char
            endfor
        else
            echo "python2.7 or uconv is required for custom mapping, if it has a different name you need to specify it in your .vimrc function with `let g:python27location = `. Using earlier versions of python might work but it isn't supported. Python 3 will not."
            let g:yidnoncomp2precomp = g:defaultyidnoncomp2precomp
            let g:yidprecomp2noncomp = g:defaultyidprecomp2noncomp
        endif
    endif
endif

function! RegexThing() range
    if &encoding == 'utf-8'
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
