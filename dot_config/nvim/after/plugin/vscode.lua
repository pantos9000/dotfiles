if not vim.g.vscode then
    return
end

local vscode = require('vscode-neovim')

local function map(mode, lhs, rhs, opts)
    local options = { noremap = false, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- use vscode notification output
vim.notify = vscode.notify

map('n', 'gr', function() vscode.call("editor.action.goToReferences") end)
map('n', 'gR', function() vscode.call("references-view.findReferences") end)
map('n', 'ga', function() vscode.call("editor.action.refactor") end)
map('v', 'ga', function() vscode.call("editor.action.refactor") end)

map('n', '<leader>x', function() vscode.call("workbench.actions.view.problems") end)
map('n', '<leader>r', function() vscode.call("editor.action.rename") end)

-- telescope does not work in vscode, so use the vscode api
map('n', '<leader>pf', function() vscode.call("workbench.action.quickOpen") end) -- find files
map('n', '<leader>pg', function() vscode.call("workbench.action.findInFiles") end) -- find in files

-- comment toggle and movements with alt+<key> is done in vscodium config
