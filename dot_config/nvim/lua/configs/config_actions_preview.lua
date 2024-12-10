local M = function()
    local function map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true, buffer = bufnr }
        if opts then
            options = vim.tbl_extend('force', options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
    end

    require('actions-preview').setup {
        highlight_command = {
            require("actions-preview.highlight").delta(),
        },
    }
    map('n', 'ga', require("actions-preview").code_actions, { desc = 'code action' })
    map('v', 'ga', require("actions-preview").code_actions, { desc = 'code action' })
    map('n', '<C-.>', require("actions-preview").code_actions, { desc = 'code action' })
    map('v', '<C-.>', require("actions-preview").code_actions, { desc = 'code action' })
    map('i', '<C-.>', require("actions-preview").code_actions, { desc = 'code action' })
end

return M
