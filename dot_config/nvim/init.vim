source ~/.config/nvim/plugins.vim
source ~/.config/nvim/syntastic.vim
source ~/.config/nvim/indentation.vim
source ~/.config/nvim/folding.vim
source ~/.config/nvim/colors.vim
source ~/.config/nvim/orgmode.vim
source ~/.config/nvim/mappings.vim

"
" other plugin settings
"
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_map_keys = 0

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='simple'
let g:airline_symbols = {}
let g:airline_symbols.branch = 'git:'
let g:airline_symbols.linenr = 'L'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.notexists = 'Ø'
let g:airline_symbols.whitespace = '·'

let g:move_map_keys = 0 "use own bindings for vim-move

set nrformats=alpha,hex "visual incr/decr

let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1 "add spaces after comment delimiters
let g:NERDTrimTrailingWhitespace = 1

let g:matchup_matchparen_enabled = 1
let g:matchup_motion_enabled = 1
let g:matchup_text_obj_enabled = 1
let g:matchup_matchparen_offscreen = {}



"
" status line
"
set statusline+=%#warningmsg#
set statusline+=%{fugitive#statusline()}
set statusline+=%*



"
" scrolling
"
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1



"
" other settings
"
set nocompatible
set modelines=0                     "disable vim modelines in files
set nomodeline
set linebreak                       "break lines nicer
set mouse=r
set number
syn on

set undofile                        "support undo after close
set undodir=/tmp/vim_undo

set ignorecase
set smartcase
set incsearch
set noshowmatch
set hlsearch

set wildmenu
set wildmode=longest,list

set autoread                        "auto reload changed files
au CursorHold * checktime           "auto reload changed files

set noshowmode                      "mode is already shown by status line
set clipboard+=unnamedplus          "use system clipboard by default
set inccommand=nosplit              "use incremental replace
set diffopt+=vertical               "prefer vertical diffs

filetype plugin on

set encoding=utf-8                  "Necessary to show Unicode glyphs

hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
if &diff
    hi DiffAdd      ctermfg=Black        ctermbg=LightGreen
    hi DiffChange   ctermfg=White        ctermbg=DarkGrey
    hi DiffDelete   ctermfg=DarkBlue     ctermbg=DarkGrey
    hi DiffText     ctermfg=Black        ctermbg=Red
endif
