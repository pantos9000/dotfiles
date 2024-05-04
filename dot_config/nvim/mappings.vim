"
" mappings
"

function! ToggleNum()
    if &number == 0 && &relativenumber == 0
        set number
    elseif &number == 1 && &relativenumber == 0
        set relativenumber
    else
        set nonumber norelativenumber
    endif
endfunction

function! ToggleSyn()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction

function! ToggleGitBlame()
    if &l:filetype ==# 'fugitiveblame'
        close
    else
        Git blame
    endif
endfunction

function! ToggleGutter()
    if b:syntastic_skip_checks == 1 && g:gitgutter_enabled == 0
        GitGutterEnable
        SyntasticDisableBuffer
        echo 'Gitgutter enabled'
    elseif b:syntastic_skip_checks == 1
        GitGutterDisable
        SyntasticEnableBuffer
        echo 'Syntastic enabled'
    else
        GitGutterDisable
        SyntasticDisableBuffer
        echo 'Gitgutter and syntastic disabled'
    endif
endfunction

let g:my_help="
            \     Shortcuts [n]                        Editor controls [n]              \n
            \ F1     : help                     Tab             : bracket navigation    \n
            \ F2     : tagbar                   Space           : reset search          \n
            \ F3     : toggle gutter            gv              : select pasted text    \n
            \ F4     : toggle num               ga              : easy align            \n
            \ F5     : undotree                 -- / ==         : underline             \n
            \ F6     : toggle tab               Ctrl + y        : visual incr           \n
            \                                   Ctrl + x        : visual decr           \n
            \ F8     : toggle syntax            gt / gT         : next/prev tab         \n
            \ F9     : view git hunk            c s <x> <y>     : surrounding <x> to <y>\n
            \ F10    : undo git hunk                                                    \n
            \ F11    : git blame                      autocompletion [i]                \n
            \                                   Ctrl  + space   : autocomplete          \n
            \                                   Ctrl  + n       : vim complete          \n
            \         Tags [n]                                                          \n
            \ t t     : go to definition                   splits [ni]                  \n
            \ t r     : jump back               Ctrl + s h/v    : horiz/vert split      \n
            \ t h/v   : split definition        Ctrl + s x2     : switch split          \n
            \ t a     : list of all tags        Ctrl + s arrows : switch split          \n
            \ t d     : back to dir list        Ctrl + s =      : normalize split sizes \n
            \                                                                           \n
            \                                               Misc [niv]                  \n
            \       Orgmode [n]                 Shift + arrows  : move/indent           \n
            \ r h     : orgmode help            Ctrl  + c       : toggle comment        \n
            \"

nnoremap <silent> <F1> :echo g:my_help<CR>
nnoremap <silent> <F2> :TagbarToggle<CR>
nnoremap <silent> <F3> :call ToggleGutter()<CR>
nnoremap <silent> <F4> :call ToggleNum()<CR>
nnoremap <silent> <F5> :UndotreeToggle<CR>
nnoremap <silent> <F6> :call ToggleTab()<CR>
nnoremap <silent> <F8> :call ToggleSyn()<CR>
nnoremap <silent> <F9> :GitGutterPreviewHunk<CR>
nnoremap <silent> <F10> :GitGutterUndoHunk<CR>
nnoremap <silent> <F11> :call ToggleGitBlame()<CR>
inoremap <silent> <F1> <C-o>:echo g:my_help<CR>
inoremap <silent> <F2> <C-o>:TagbarToggle<CR>
inoremap <silent> <F3> <C-o>:call ToggleGutter()<CR>
inoremap <silent> <F4> <C-o>:call ToggleNum()<CR>
inoremap <silent> <F5> <C-o>:UndotreeToggle<CR>
inoremap <silent> <F6> <C-o>:call ToggleTab()<CR>
inoremap <silent> <F8> <C-o>:call ToggleSyn()<CR>
inoremap <silent> <F9> <C-o>:GitGutterPreviewHunk<CR>
inoremap <silent> <F10> <C-o>:GitGutterUndoHunk<CR>
inoremap <silent> <F11> <C-o>:GitGutterStageHunk<CR>

inoremap <silent><C-Space> <C-r>=ncm2#manual_trigger()<CR>
inoremap <expr> <CR> pumvisible() ? ncm2_ultisnips#expand_or("<Plug>(ncm2_ultisnips_expand_completed)") : "\<CR>"

nmap <silent> <S-Up> <Plug>MoveLineUp
nmap <silent> <S-Down> <Plug>MoveLineDown
nmap <silent> <S-PageUp> <Plug>MoveLineHalfPageUp
nmap <silent> <S-PageDown> <Plug>MoveLineHalfPageDown
imap <silent> <S-Up> <C-o><Plug>MoveLineUp
imap <silent> <S-Down> <C-o><Plug>MoveLineDown
imap <silent> <S-PageUp> <C-o><Plug>MoveLineHalfPageUp
imap <silent> <S-PageDown> <C-o><Plug>MoveLineHalfPageDown
vmap <silent> <S-Up> <Plug>MoveBlockUp
vmap <silent> <S-Down> <Plug>MoveBlockDown
vmap <silent> <S-PageUp> <Plug>MoveBlockHalfPageUp
vmap <silent> <S-PageDown> <Plug>MoveBlockHalfPageDown

nmap <silent> <S-Left> <<
nmap <silent> <S-Right> >>
imap <silent> <S-Left> <C-o><<
imap <silent> <S-Right> <C-o>>>
vmap <silent> <S-Left> <gv
vmap <silent> <S-Right> >gv

nnoremap <silent> <S-u> :redo<CR>

nnoremap <silent> <C-Up> 10<Up>
nnoremap <silent> <C-Down> 10<Down>
inoremap <silent> <C-Up> <C-o>10<Up>
inoremap <silent> <C-Down> <C-o>10<Down>
vnoremap <silent> <C-Up> 10<Up>
vnoremap <silent> <C-Down> 10<Down>
nnoremap <silent> <C-Left> b
inoremap <silent> <C-Left> <C-o>b
vnoremap <silent> <C-Left> b
nnoremap <silent> <C-Right> w
inoremap <silent> <C-Right> <C-o>w
vnoremap <silent> <C-Right> w

nnoremap <silent> <PageUp> 50<Up>
nnoremap <silent> <PageDown> 50<Down>
inoremap <silent> <PageUp> <C-o>50<Up>
inoremap <silent> <PageDown> <C-o>50<Down>
nnoremap <silent> <PageUp> 50<Up>
nnoremap <silent> <PageDown> 50<Down>


" visual de-/increment
nmap <silent> <C-y> <Plug>VisualIncrement
vmap <silent> <C-y> <Plug>VisualIncrement
nmap <silent> <C-x> <Plug>VisualDecrement
vmap <silent> <C-x> <Plug>VisualDecrement

" jump between tags
nnoremap tt <C-]>
nnoremap tv <C-w><C-]>
nnoremap th :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap tr <C-t>
nnoremap ta g<C-]>
nnoremap td :b#<CR>

" clear highlighting
nnoremap <silent> <space> :noh<CR>

" jump between parens
nmap <tab> %
vmap <tab> %

" select pasted txt
nnoremap gv `[v`]

" easy align in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" easy align (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" underline in normal mode
nmap == yypVr=
nmap -- yypVr-

" un-/comment
inoremap <silent> <C-c> <C-o>:call nerdcommenter#Comment(0, "Toggle")<CR>
nnoremap <silent> <C-c>      :call nerdcommenter#Comment(0, "Toggle")<CR>
vnoremap <C-c>               :call nerdcommenter#Comment(0, "Toggle")<CR>

" next/prev/endof word
nnoremap W B
nnoremap E ge

" marker
nmap , '
omap , '
vmap , '

" split
nnoremap <silent> <C-s>h :vsplit<CR>
nnoremap <silent> <C-s>v :split<CR>
nnoremap <silent> <C-s><C-s> <C-w><C-w>
nnoremap <silent> <C-s><Left> <C-w><Left>
nnoremap <silent> <C-s><Right> <C-w><Right>
nnoremap <silent> <C-s><Up> <C-w><Up>
nnoremap <silent> <C-s><Down> <C-w><Down>
nnoremap <silent> <C-s>= <C-w>=

inoremap <C-s>h <C-o>:vsplit<CR>
inoremap <C-s>v <C-o>:split<CR>
inoremap <C-s><C-s> <C-o><C-w><C-w>
inoremap <C-s><Left> <C-o><C-w><Left>
inoremap <C-s><Right> <C-o><C-w><Right>
inoremap <C-s><Up> <C-o><C-w><Up>
inoremap <C-s><Down> <C-o><C-w><Down>
inoremap <C-s>= <C-o><C-w>=

" easymotion
nmap j <Plug>(easymotion-bd-w)
vmap j <Plug>(easymotion-bd-w)

" use suda plugin for write sudo authentication
command! W w suda://%

" use :Q to close all tabs and buffers
cnoreabbrev Q qa

" file-specific mappings
au BufEnter *.org source ~/.config/nvim/mappings-orgmode.vim
