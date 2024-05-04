local M = function()
    local oil = require('oil')

    vim.keymap.set('n', '<leader>e', require('oil').toggle_float, { desc = 'file explorer (float)' })
    vim.keymap.set('n', '<leader>E', require('oil').open, { desc = 'file explorer (open in current buffer)' })

    oil.setup({
        default_file_explorer = true,
        use_default_keymaps = true,
        columns = {
            "permissions",
            "size",
            "icon",
            -- "mtime",
        },
        keymaps = {
            ["?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            -- ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-r>"] = "actions.refresh",
            ["<bs>"] = "actions.parent",
            ["-"] = "actions.open_cwd",
            ["_"] = "actions.cd",
            ["H"] = "actions.toggle_hidden",
        },
    })
end

return M
