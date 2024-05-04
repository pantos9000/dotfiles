if not packer_plugins['telescope'] or not packer_plugins['telescope'].loaded then
    return
end

local builtin = require('telescope.builtin')
local telescope = require('telescope')

vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'find in buffer' })

vim.keymap.set('n', '<leader>pF', builtin.find_files, { desc = 'find files' })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'grep in files' })
vim.keymap.set('n', '<leader>pf', builtin.git_files, { desc = 'find git files' })
vim.keymap.set('n', '<leader>pv', builtin.help_tags, { desc = 'grep in vim help' })
vim.keymap.set('n', '<leader>pm', builtin.man_pages, { desc = 'find man pages' })
vim.keymap.set('n', '<leader>pn', telescope.extensions.notify.notify, { desc = 'find in notifications' })

vim.keymap.set('n', '<leader>pj', builtin.jumplist, { desc = 'find in jumplist' })

vim.keymap.set('n', '<leader>gC', builtin.git_commits, { desc = 'find commits' })
vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, { desc = 'find commits for this file' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'git status' })
vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'find in git stash' })
