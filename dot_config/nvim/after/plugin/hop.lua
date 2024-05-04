local hop = require('hop')

-- jump to words
vim.keymap.set({ 'n', 'v' }, 'j', function()
    hop.hint_words()
end, { remap = true, desc = 'jump to word' })

-- jump to char
vim.keymap.set({ 'n', 'v' }, 'k', function()
    hop.hint_char1()
end, { remap = true, desc = 'jump to char' })

-- insert mode
vim.keymap.set('i', '<C-j>', '<C-o>j', { remap = true, desc = 'jump to word (insert mode)' })
vim.keymap.set('i', '<C-k>', '<C-o>k', { remap = true, desc = 'jump to char (insert mode)' })
