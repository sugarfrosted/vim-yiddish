scriptencoding utf-8
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    " ToDo: give credit in README.md to:
    " http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction
if !exists("g:debugwithPY")
    let g:debugwithPY = 1
endif
let s:defaultdecompchars = ["אַ", "אָ", "כּ", "פּ", "פֿ", "בֿ", "תּ", "יִ", "וּ", "ײַ", "שׂ"]
"for testing v
"let g:yiddish_decomp_chars = ["אָ", "כּ", "פּ", "פֿ", "בֿ", "תּ", "יִ", "וּ", "ײַ", "שׂ"]
call uniq(sort(s:defaultdecompchars))
lockvar s:defaultdecompchars
let s:defaultyidnoncomp2precomp = {"אַ" : "אַ","אָ" : "אָ","וּ" : "וּ","יִ" : "יִ",
            \"פּ" : "פּ","פֿ" : "פֿ","תּ" : "תּ","כּ" : "כּ","שׂ" : "שׂ","ײַ" : "ײַ",
            \"בֿ" : "בֿ"}
let s:defaultyidprecomp2noncomp = {"אַ" : "אַ","אָ" : "אָ","וּ" : "וּ","יִ" : "יִ",
            \"פּ" : "פּ","פֿ" : "פֿ","תּ" : "תּ","כּ" : "כּ","שׂ" : "שׂ","ײַ" : "ײַ",
            \"בֿ" : "בֿ"}
lockvar s:defaultyidnoncomp2precomp
lockvar s:defaultyidprecomp2noncomp
if !exists("g:yiddish_decomp_chars")
    let g:yiddish_decomp_chars = copy(s:defaultdecompchars)
    let g:yidnoncomp2precomp = copy(s:defaultyidnoncomp2precomp)
    let g:yidprecomp2noncomp = copy(s:defaultyidprecomp2noncomp)
endif
call uniq(sort(g:yiddish_decomp_chars))
if g:yiddish_decomp_chars == s:defaultdecompchars
    let g:yidnoncomp2precomp = copy(s:defaultyidnoncomp2precomp)
    let g:yidprecomp2noncomp = copy(s:defaultyidprecomp2noncomp)
elseif executable("uconv")
    let g:yidnoncomp2precomp = {}
    let g:yidprecomp2noncomp = {}
    for s:char in g:yiddish_decomp_chars
        let s:dechar = system("uconv -x any-nfd <<<" . s:char)
        let s:dechar = substitute(s:dechar,"\n","","g") 
        let g:yidprecomp2noncomp[s:char] = s:dechar
        let g:yidnoncomp2precomp[s:dechar] = s:char
    endfor
elseif has("python") 
python << endpython
import vim
from unicodedata import normalize
vim.vars["yidnoncomp2precomp"] = {}
vim.vars["yidprecomp2noncomp"] = {}
for char in vim.vars["yiddish_decomp_chars"]:
    charhold = char.decode('utf-8')
    vim.vars["yidnoncomp2precomp"][normalize('NFD',charhold)] = charhold
    vim.vars["yidprecomp2noncomp"][charhold] = normalize('NFD',charhold)
endpython
elseif executable(g:python27location)
    if !exists("g:python27location")
        let g:python27location = "python2.7"
    endif
    let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
    let g:yidnoncomp2precomp = {}
    let g:yidprecomp2noncomp = {}
    for s:char in g:yiddish_decomp_chars
        let s:dechar = system(g:python27location . " " . s:path . "/decomp.py " . s:char)
        let g:yidprecomp2noncomp[s:char] = s:dechar
        let g:yidnoncomp2precomp[s:dechar] = s:char
    endfor
else
    echo "python2.7 or uconv is required for custom mapping, if it has a different name you need to specify it in your .vimrc function with `let g:python27location = `. Using earlier versions of python might work but it isn't supported. Python 3 will not."
    let g:yidnoncomp2precomp = copy(s:defaultyidnoncomp2precomp)
    let g:yidprecomp2noncomp = copy(s:defaultyidprecomp2noncomp)
endif
 
function! YiddishShortCuts()
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
        let dictat = g:yidnoncomp2precomp
        if !g:precomposed
            let g:precomposed=1
            set spelllang=yi-pc
            for char in keys(dictat)
                execute "iabbrev " . char . " " . dictat[char] 
            endfor
            echo "Not Precomposed"
        else
            let g:precomposed=0
            set spelllang=yi
            for char in keys(dictat)
                execute "iunabbrev " . dictat[char]
            endfor
            echo "Precomposed"
        endif
    else
        echo "Encoding lacks precomposed variants"
    endif
endfunction

function! Composure_init()
    if !exists("g:precomposed")
        let g:precomposed = 1
    endif
    let dictat = g:yidnoncomp2precomp
    if !g:precomposed && &encoding == 'utf-8'
        for char in keys(dictat)
            execute "iabbrev " . char . " " . dictat[char] 
        endfor
    endif
endfunction

call Composure_init()

function! YiddishKeyBoard()
    if !exists("w:yidl") "sets default value for w:yidl if not yet set
        let w:yidl=0 "assumed initial value
    endif
    if w:yidl "turns off Yiddish mode and switches back to English
        set spelllang=en_us
        set norightleft
        set keymap=""
        set norevins
        let w:yidl = 0
        echo "English"
        unmap \|
        unmap zg
        unmap zu
    else
        set keymap=yiddish
        noremap zg :call GoodBoth()<return>
        noremap zu :call UndoBoth()<return>
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
        for char in keys(dictat) 
            execute ranger . "s/" . char . "/" . dictat[char] . "/g"        
        endfor
        echo "Characters now " . direction
    else
        echo "Encoding lacks precomposed variants"
    endif
endfunction

function! ComposeString(string)
    let workingstr = copy(a:string)
    if &encoding == 'utf-8'
        for item in keys(g:yidnoncomp2precomp)
           let workingstr = substitute(copy(workingstr), item, g:yidnoncomp2precomp[item],"g")
        endfor
    endif
    return workingstr
endfunction
        

function! DeComposeString(string)
    let workingstr = copy(a:string)
    if &encoding == 'utf-8'
        for item in keys(g:yidnoncomp2precomp)
           let workingstr = substitute(copy(workingstr), item, g:yidprecomp2noncomp[item],"g")
        endfor
    endif
    return workingstr
endfunction

function! GoodBoth()
     let spellhold = &spelllang
     if &spelllang == "yi" || &spelllang == "yi-pc"
         if mode() == "v" && getpos("'<")[1] == getpos("'>")[1]
             let stringtemp = s:get_visual_selection()
             set spelllang=yi-pc
             let stringtempd = DeComposeString(stringtemp)
             execute "spellgood " . stringtempd
             set spelllang=yi
             let stringtempc = ComposeString(stringtemp)
             execute "spellgood " . stringtempc
         elseif mode() == "n"
            let stringtemp = expand("<cword>")
            execute "spellgood " . stringtemp
         endif
         if exists("l:stringtemp")
             if !exists("s:addedlist")
                 let s:YIaddedlist = [stringtemp]
             else
                 call add(s:YIaddedlist, stringtemp)
             endif
         endif
     endif
     let &spelllang = spellhold
endfunction

function! UndoBoth()
    if exist("s:YIaddedlist")
        let spellhold = &spelllang
        if (&spelllang == "yi" || &spelllang == "yi-pc") && s:YIaddedlist
            let coord = len(s:YIaddedlist) - 1
            let stringtemp = s:YIaddedlist[coord]
            let s:YIaddedlist = remove(s:YIaddedlist, coord - 1)
            set spelllang=yi-pc
            let stringtempd = DeComposeString(stringtemp)
            execute "spellundo " . stringtempd
            set spelllang=yi
            let stringtempc = ComposeString(stringtemp)
            execute "spellundo " . stringtempc
        endif
        let &spelllang = spellhold
    endif
    if !exist("s:YIaddedlist") || !s:YIaddedlist
        echo "Undo tree empty"
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
