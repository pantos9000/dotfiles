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

-- set color
vim.cmd([[highlight Whitespace ctermfg=darkcyan guifg=darkcyan]])
