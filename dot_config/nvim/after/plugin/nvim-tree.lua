-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.keymap.set('n', '<leader>e', '<cmd> NvimTreeToggle<CR>', { desc = 'file explorer' })

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = false, silent = true, nowait = true }
    end

    -- default mappings
    -- api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', 'gh', api.node.show_info_popup, opts('Info'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
    vim.keymap.set('n', 'zM', api.tree.collapse_all, opts('Collapse all'))

    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))

    vim.keymap.set('n', '<S-Right>', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '<S-Left>', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', '<S-Down>', api.node.navigate.sibling.last, opts('Last Sibling'))
    vim.keymap.set('n', '<S-Up>', api.node.navigate.sibling.first, opts('First Sibling'))
    vim.keymap.set('n', 'gn', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
    vim.keymap.set('n', 'gp', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))

    vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter filenames'))
    vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))

    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'c', api.fs.rename_basename, opts('Rename: Basename'))
    vim.keymap.set('n', 'C', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))

    vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
    vim.keymap.set('n', 'D', api.marks.bulk.delete, opts('Delete Bookmarked'))
    vim.keymap.set('n', 'X', api.marks.bulk.move, opts('Move Bookmarked'))

    vim.keymap.set('n', 'YY', api.fs.copy.filename, opts('Path Copy File Name'))
    vim.keymap.set('n', 'Yp', api.fs.copy.relative_path, opts('Copy Relative Path'))
    vim.keymap.set('n', 'YP', api.fs.copy.absolute_path, opts('Copy Absolute Path'))

    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
end

-- setup with some options
require("nvim-tree").setup({
    on_attach = my_on_attach,
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    git = {
        ignore = false, -- TODO verify this works
    }
})
