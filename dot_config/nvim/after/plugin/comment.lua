require('Comment').setup({
    sticky = true,
    toggler = {
        line = '<C-c><C-c>',  -- toggle with line comment
        block = '<C-c><C-b>', -- toggle with block comment
    },
    opleader = {
        line = '<C-c><C-c>',  -- toggle with line comment
        block = '<C-c><C-b>', -- toggle with block comment
    },
    extra = {
        above = '<C-c><Up>',   -- add comment in line above
        below = '<C-c><Down>', -- add comment in line below
        eol = '<C-c><Right>',  -- add comment at end of line
    },
})

-- also allow shortcuts in insert mode
vim.keymap.set('i', '<C-c><C-c>', '<C-o><C-c><C-c>',
    { remap = true, desc = 'toggle comment line (insert mode)' })
vim.keymap.set('i', '<C-c><C-b>', '<C-o><C-c><C-b>',
    { remap = true, desc = 'toggle comment block (insert mode)' })
vim.keymap.set('i', '<C-c><Up>', '<C-o><C-c><Up>',
    { remap = true, desc = 'add comment above (insert mode)' })
vim.keymap.set('i', '<C-c><Down>', '<C-o><C-c><Down>',
    { remap = true, desc = 'add comment below (insert mode)' })
vim.keymap.set('i', '<C-c><Right>', '<C-o><C-c><Right>',
    { remap = true, desc = 'add comment at end of line (insert mode)' })
