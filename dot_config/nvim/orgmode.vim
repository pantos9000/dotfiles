" prefer insert mode after new heading/checkbox/plainlist
let org_prefer_insert_mode = 1

" show formatting characters
let g:org_aggressive_conceal = 0

" indent text
let g:org_indent = 1

" show leading stars in grey
let g:org_heading_shade_leading_stars = 1

" some todo states
let g:org_todo_keywords = [
    \ ['TODO', '|'],
    \ ['WAIT', '|'],
    \ ['|', 'DONE'],
    \ ['|', 'CANC']]
let g:org_todo_keyword_faces = [
    \ ['WAIT',
    \   [':foreground darkcyan', ':background darkgrey', ':weight bold', ':slant italic']],
    \ ['CANC',
    \   [':foreground red', ':background black', ':weight bold', ':slant italic',
    \     ':decoration underline']]]
