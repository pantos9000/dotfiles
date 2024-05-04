local M = function()
    require('Comment').setup({
        sticky = true,
        toggler = {
            line = '<C-c>',  -- toggle with line comment
            block = '<C-b>', -- toggle with block comment
        },
        opleader = {
            line = '<C-c>',  -- toggle with line comment
            block = '<C-b>', -- toggle with block comment
        },
        mappings = {
            basic = true,
            extra = false,
        }
    })

    -- also allow shortcuts in insert mode
    vim.keymap.set('i', '<C-c>', '<C-o><C-c>',
        { remap = true, desc = 'toggle comment line (insert mode)' })
    vim.keymap.set('i', '<C-b>', '<C-o><C-b>',
        { remap = true, desc = 'toggle comment block (insert mode)' })
end

return M
