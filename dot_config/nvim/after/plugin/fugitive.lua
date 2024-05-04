local toggle_git_blame = function()
    if vim.bo.filetype == 'fugitiveblame'
    then
        vim.cmd('close')
    else
        vim.cmd('Git blame')
    end
end

vim.keymap.set('n', '<leader>gb', toggle_git_blame, { desc = 'show blame for whole file' })
