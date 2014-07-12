function! YiddishShortCuts()
    if exists("g:OldYiddishKeys")
        if type(g:OldYiddishKeys) == type("")
            execute "nunmap " . mapping . " Yidkey<Enter>"
        elseif type(g:OldYiddishKeys) == type([])
            for mapping in g:OldYiddishKeys
                execute "nunmap " . mapping . " Yidkey<Enter>"
            endfor
        endif
    endif
    if !exists("g:YiddishKeys")
        let g:YiddishKeys = ["t","T"]
    endif
    if type(g:YiddishKeys) == type("")
        execute "nnoremap " . mapping . " Yidkey<Enter>"
    else
        if type(g:YiddishKeys) == type([])
        else
            let g:YiddishKeys = ["t","T"]
        endif
        for mapping in g:YiddishKeys
            execute "nnoremap " . mapping . " Yidkey<Enter>"
        endfor
    endif
    let g:OldYiddishKeys = g:YiddishKeys
    noremap <Leader>tran :CompTransSel<Enter>
    noremap <Leader>tral :CompTransAll<Enter>
    inoremap R <c-\><c-O>:Yidkey<Enter>
endfunction

command YiddishSC :call YiddishShortCuts()
let g:precomposed=1
function! Composure()
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
        let w:decompchars=""
        let w:yidl = 0
        echo "English"
        unmap \|
    else
        set keymap=yiddishprecomp_utf-8
        let w:decompchars="אַאָכּפּפֿבֿתּיִוּײַשׂ"
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

python << endpython
import vim
from unicodedata import normalize
def regexthing(decomposables = "URABIGDUMMY"):
    if decomposables == "URABIGDUMMY":
        chars = vim.current.window.buffer.vars["decompchars"]
    if vim.vars["precomposed"]:#seems wrong
        for char in chars.decode('utf-8'):
            vim.command("'<,'>s/"+normalize('NKD',char)+"/"+char+"/g")        
            print("Characters now precomposed")
    else:
        for char in chars.decode('utf-8'):
            vim.command("'<,'>s/"+char+"/"+normalize('NKD',char)+"/g")        
            print("Characters now decomposed")
def regexthingall(decomposables = "URABIGDUMMY"):
    if decomposables == "URABIGDUMMY":
        chars = vim.current.window.buffer.vars["decompchars"]
    if vim.vars["precomposed"]:#seems wrong
        for char in chars.decode('utf-8'):
            vim.command("'<,'>s/"+normalize('NKD',char)+"/"+char+"/g")        
            print("Characters now precomposed")
    else:
        for char in chars.decode('utf-8'):
            vim.command("'<,'>s/"+char+"/"+normalize('NKD',char)+"/g")        
            print("Characters now decomposed")
endpython


command Yidkey :call YiddishKeyBoard()
command Precomp :call Composure()
command CompTransAll :py regexthingall
command CompTransSel :py regexthing
if !exists("g:YiddishEnabled")
    let g:YiddishEnabled = 0
endif
if g:YiddishEnabled
    autocmd VimEnter * call YiddishShortCuts()
endif
