let maplocalleader = "r"

let g:my_orgmode_help="
            \    Orgmode shortcuts [n]                      \n
            \ localleader: r                                \n
            \ <ll> h        : show this help                \n
            \                                               \n
            \ CR            : new item below                \n
            \ <ll> -        : new list item below           \n
            \ <ll> #        : new checkbox item below       \n
            \ <ll> r        : jump to parent                \n
            \                                               \n
            \ <ll> x        : toggle checkbox state         \n
            \ <ll> t        : set TODO state                \n
            \ <ll> /        : Append checkbox progress      \n
            \ <ll> %        : Append checkbox progress in % \n
            \                                               \n
            \                                               \n
            \ <ll> Down     : move subtree down             \n
            \ <ll> Up       : move subtree up               \n
            \ <ll> Right    : demote heading                \n
            \ <ll> Left     : promote heading               \n
            \                                               \n
            \ <ll> ,        : set tag                       \n
            \ <ll> f        : find tag                      \n
            \                                               \n
            \ <ll> e b      : export BeamerPDF              \n
            \ <ll> e h      : export HTML                   \n
            \ <ll> e l      : export LaTeX                  \n
            \ <ll> e m      : export Markdown               \n
            \ <ll> e p      : export PDF                    \n
            \                                               \n
            \    Orgmode insertmode shortcuts [i]           \n
            \ ctrl CR       : new item below                \n
            \ ctrl r        : jump to parent                \n
            \"


" normal mode mappings

nmap <silent> <localleader>h :echo g:my_orgmode_help<CR>

nmap <silent> <localleader>- <Plug>OrgPlainListItemNewBelow
nmap <silent> <localleader># <Plug>OrgCheckBoxNewBelow
nmap <silent> <localleader>r <Plug>OrgJumpToPreviousSkipChildrenNormal

nmap <silent> <localleader>x <Plug>OrgCheckBoxToggle
nmap <silent> <localleader>t <Plug>OrgTodoToggleInteractive
nmap <silent> <localleader>% A<space>[%]<Esc>
nmap <silent> <localleader>/ A<space>[/]<Esc>

nmap <silent> <localleader><Down> <Plug>OrgMoveSubtreeDownward
nmap <silent> <localleader><Up> <Plug>OrgMoveSubtreeUpward
nmap <silent> <localleader><Right> <Plug>OrgDemoteOnHeadingNormal
nmap <silent> <localleader><Left> <Plug>OrgPromoteOnHeadingNormal

nmap <silent> <localleader>, <Plug>OrgSetTags
nmap <silent> <localleader>f <Plug>OrgFindTags

nmap <silent> <localleader>eb <Plug>OrgExportToBeamerPDF
nmap <silent> <localleader>eh <Plug>OrgExportToHTML
nmap <silent> <localleader>el <Plug>OrgExportToLaTeX
nmap <silent> <localleader>em <Plug>OrgExportToMarkdown
nmap <silent> <localleader>ep <Plug>OrgExportToPDF


" insert mode mappings (C-J = C-CR)

imap <silent> <C-J> <C-o><Plug>OrgNewHeadingBelowAfterChildrenNormal
imap <silent> <C-r> <C-o><Plug>OrgJumpToPreviousSkipChildrenNormal


" unmap vim-orgmode's shift+arrow mapping

silent! unmap <buffer> <S-Left>
silent! unmap <buffer> <S-Right>
