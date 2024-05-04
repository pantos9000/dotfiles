" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" auto-update vim-plug once
if empty(glob('/tmp/.nvim-checked-update'))
    silent !touch /tmp/.nvim-checked-update
    autocmd VimEnter * PlugUpgrade
endif

" plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/airblade/vim-gitgutter'

" autocomplete
Plug 'https://github.com/ncm2/ncm2'
Plug 'https://github.com/roxma/nvim-yarp'
augroup NCM2
  autocmd!
  autocmd BufEnter * call ncm2#enable_for_buffer()
  set completeopt=menuone,longest,noinsert,noselect
  set shortmess+=c
  let g:ncm2#auto_popup = 0
  let g:UltiSnipsJumpForwardTrigger	= "<C-Right>"
  let g:UltiSnipsJumpBackwardTrigger	= "<C-Left>"
  let g:UltiSnipsRemoveSelectModeMappings = 0
augroup END

Plug 'https://github.com/ncm2/ncm2-ultisnips' " func param completion
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/ncm2/ncm2-bufword' " word from current buffer
Plug 'https://github.com/ncm2/ncm2-path' " from dirs/files
Plug 'https://github.com/ncm2/ncm2-tmux' " from other tmux panes
Plug 'https://github.com/ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax' " from vim syntax file
Plug 'https://github.com/ncm2/ncm2-neoinclude' | Plug 'Shougo/neoinclude.vim' " provides include completion for 
Plug 'https://github.com/ncm2/ncm2-cssomni' " CSS
Plug 'https://github.com/ncm2/ncm2-tern',  {'do': 'npm install'} " javascript
Plug 'https://github.com/ncm2/ncm2-jedi' " python
Plug 'https://github.com/ncm2/ncm2-racer' " rust
Plug 'https://github.com/ncm2/ncm2-pyclang' " c/c++
Plug 'https://github.com/ncm2/ncm2-vim' | Plug 'https://github.com/Shougo/neco-vim' " vim script

Plug 'https://github.com/easymotion/vim-easymotion'"{{{
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'asdghlqwertzuiopyxcvbnmfjk'
"}}}

Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/triglav/vim-visual-increment'
Plug 'https://github.com/matze/vim-move'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/jceb/vim-orgmode'
Plug 'https://github.com/lambdalisue/suda.vim'
Plug 'https://github.com/andymass/vim-matchup'
Plug 'https://github.com/pseewald/vim-anyfold'
Plug 'https://github.com/sheerun/vim-polyglot'
let g:polyglot_disabled = ['org']
Plug 'https://github.com/justinmk/vim-syntax-extra'

Plug 'https://github.com/semanser/vim-outdated-plugins'
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/ludovicchabant/vim-gutentags'"{{{
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]
set statusline+=%{gutentags#statusline()}
"}}}

call plug#end()
