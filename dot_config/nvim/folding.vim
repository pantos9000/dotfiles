filetype plugin indent on   " required
syntax on                   " required

set foldlevel=99

let g:anyfold_fold_display=1        " minimalistic display of closed folds
let g:anyfold_motion=0              " map motion commands
let g:anyfold_identify_comments=2   " identify lines to ignore for better folding
                                    " 0: off, 1: foldignore, 2: foldignore and syntax
let g:anyfold_fold_comments=1       " fold multiline comments
let g:anyfold_fold_toplevel=1       " fold subsequent unindented lines

" activate anyfold by default, but not for large files
augroup anyfold
    autocmd!
    autocmd Filetype * AnyFoldActivate
augroup END
let g:LargeFile = 1000000 " file is large if size greater than 1MB
autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
function LargeFile()
    augroup anyfold
        autocmd! " remove AnyFoldActivate
        autocmd Filetype <filetype> setlocal foldmethod=indent " fall back to indent folding
    augroup END
endfunction
