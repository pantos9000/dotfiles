-- quick navigation sidebar
return {
    'stevearc/aerial.nvim',
    config = function()
        require('aerial').setup({
            -- Priority list of preferred backends for aerial.
            -- This can be a filetype map (see :help aerial-filetype-map)
            backends = { "treesitter", "lsp", "markdown", "man" },
            layout = {
                default_direction = 'prefer_right',
            },
            lazy_load = true,
            autojump = false, -- autojump is broken with new buffers :(
            keymaps = {
                ["?"] = "actions.show_help",
                ["q"] = "actions.close",
                ["<CR>"] = "actions.jump",
                ["<Down>"] = "actions.next",
                ["<Up>"] = "actions.prev",
            }
        })
        vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>')
    end,
}
