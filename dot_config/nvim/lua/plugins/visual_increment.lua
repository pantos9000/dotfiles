-- cumulative increment in visual mode
return {
    'triglav/vim-visual-increment',
    config = function()
        vim.keymap.set('v', '<leader><C-a>', '<Plug>VisualIncrement', { desc = 'cumulative increment' })
        vim.keymap.set('v', '<leader><C-x>', '<Plug>VisualDecrement', { desc = 'cumulative decrement' })
    end
}
