local M = function()
    require('gitsigns').setup {
        numhl = true, -- highlight changed line nums
        current_line_blame = true,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },

        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', '<leader>g<Down>', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = 'go to next hunk' })

            map('n', '<leader>g<Up>', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = 'go to prev hunk' })

            -- Actions
            map('n', '<leader>ga', gs.stage_hunk, { desc = 'add/stage hunk' })
            map('v', '<leader>ga', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                { desc = 'add/stage hunk' })
            map('n', '<leader>gA', gs.stage_buffer, { desc = 'add/stage whole buffer' })
            map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'undo last stage' })
            map('n', '<leader>gr', gs.reset_hunk, { desc = 'reset hunk' })
            map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                { desc = 'reset hunk' })
            map('n', '<leader>gR', gs.reset_buffer, { desc = 'reset whole buffer' })
            map('n', '<leader>gg', function() gs.blame_line { full = true } end,
                { desc = 'show blame for current line' })
            map('n', '<leader>gd', gs.preview_hunk, { desc = 'show hunk diff' })
            map('n', '<leader>gD', gs.diffthis, { desc = 'show diff for file' })
            map('n', '<leader>gt', gs.toggle_deleted, { desc = 'toggle show deleted lines' })
            map('n', '<leader>gn', gs.next_hunk, { desc = 'next hunk' })
            map('n', '<leader>gp', gs.prev_hunk, { desc = 'prev hunk' })
            -- toggle git blame for file mapped in fugitive.lua
            -- commits, status and stash in telescope.lua

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'inner hunk' })
        end
    }
end

return M
