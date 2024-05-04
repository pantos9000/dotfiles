-- nvim settings
-- see https://neovim.io/doc/user/options.html

-- relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- display tabs and EOL spaces
vim.opt.list = true
vim.opt.listchars = {
    lead = '·',
    trail = '·',
    tab = '▸ ',
    extends = '⮞',
    precedes = '⮜',
    -- nbsp = '·',
    -- eol = '¬',
}
vim.cmd([[highlight Whitespace ctermfg=darkcyan guifg=darkcyan]])


-- tabstop
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.sidescroll = 1

-- use undofiles instead of swapfiles
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

-- incremental search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ignore case if only lowercase pattern
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- use 24-bit RGB color
vim.opt.termguicolors = true

-- min # of lines to show before/after cursor
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 15

-- always show gutter
vim.opt.signcolumn = "yes"

-- show line-break column on the right
vim.opt.colorcolumn = "100"

-- turn off modelines
vim.opt.modeline = false

-- only enable mouse in visual and normal mode (for mark&copy in other modes)
vim.opt.mouse = 'nv'

-- auto reload changed files
vim.opt.autoread = true

-- use system clipboard by default
--table.insert(vim.opt.clipboard, 'unnamedplus')
vim.opt.clipboard = 'unnamedplus'

-- prefer vertical diffs
table.insert(vim.opt.diffopt, 'vertical')

-- UTF-8 FTW \o/
vim.opt.encoding = 'utf-8'
