if exists("g:enable_Yiddish") && g:enable_Yiddish
    noremap t :Yidkey<Enter>
    noremap T :Yidkey<Enter>
    noremap <Leader>tran :call YiddishComposingTranslation()<Enter>
    inoremap <F8> :Yidkey<Enter>
endif
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
        if &termbidi
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



command Yidkey :call YiddishKeyBoard()
command Precomp :call Composure()
command CompTrans :call YiddishComposingTranslation()
