return {
    "mfussenegger/nvim-treehopper",
    config = function()
        require('tsht').config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
        vim.keymap.set('n', '<CR>', require('tsht').nodes, { desc = 'Select regions' })
    end
}
