" display tabs and EOL spaces
set list listchars=trail:·,tab:▸\ ,extends:>,precedes:<,nbsp:· ",eol:¬


let my_tab=4
execute "set shiftwidth=".my_tab
execute "set softtabstop=".my_tab
set expandtab

" allow toggling between local and default mode
function! ToggleTab()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
    echom "Tabs set to \\t"
  else
    execute "set shiftwidth=".g:my_tab
    execute "set softtabstop=".g:my_tab
    set expandtab
    echom "Tabs set to ".g:my_tab." spaces"
  endif
endfunction
