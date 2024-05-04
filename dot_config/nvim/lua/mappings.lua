vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

map('n', '<leader>pe', vim.cmd.Ex, { desc = 'file explorer' })

-- easily go to start/end of blocks
map('n', '<Tab>', '<plug>(matchup-%)')
map('n', '<S-Tab>', function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
    if string.match(char, '[([{<]') then
        vim.cmd(':call search("[([{<]", "bW")')
    else
        vim.cmd(':call search("[])}>]", "W")')
    end
end)


-- '<cmd>call search("[([{<]")<CR>')

-- go forward/backward
map('n', 'gb', '<C-o>', { remap = true, desc = 'go backward in history' })
map('n', 'gf', '<C-i>', { remap = true, desc = 'go forward in history' })

-- move with shift
map('n', '<S-Down>', "V :m '>+1<CR>", { desc = 'move line down' })
map('v', '<S-Down>', ":m '>+1<CR>gv=gv", { desc = 'move selection down' })
map('i', '<S-Down>', "<C-o>V :m '>+1<CR>", { desc = 'move line down' })
map('n', '<S-Up>', "V :m '<-2<CR>", { desc = 'move line up' })
map('v', '<S-Up>', ":m '<-2<CR>gv=gv", { desc = 'move selection up' })
map('i', '<S-Up>', "<C-o>V :m '<-2<CR>", { desc = 'move line up' })
map('n', '<S-Left>', "<<", { desc = 'move line left' })
map('v', '<S-Left>', "<gv", { desc = 'move selection left' })
map('i', '<S-Left>', "<C-o><<", { desc = 'move line left' })
map('n', '<S-Right>', ">>", { desc = 'move line right' })
map('v', '<S-Right>', ">gv", { desc = 'move selection right' })
map('i', '<S-Right>', "<C-o>>>", { desc = 'move line right' })

-- window controls
-- <C-w>m for winshift is defined in after/plugin
map('n', '<C-w>v', '<cmd> split<CR>', { noremap = false, desc = 'vertical split' })
map('n', '<C-w>h', '<cmd> vsplit<CR>', { noremap = false, desc = 'horizontal split' })

-- let cursor stay in the middle when doing search
map('n', 'n', 'nzzzv', { desc = 'next search result' })
map('n', 'N', 'Nzzzv', { desc = 'prev search result' })

-- let cursor stay in the middle on PgUp/PgDn
map('n', '<PageDown>', '<C-d>zz', { desc = 'page down' })
map('v', '<PageDown>', '<C-d>zz', { desc = 'page down' })
map('i', '<PageDown>', '<C-o><C-d><C-o>zz', { desc = 'page down' })
map('n', '<PageUp>', '<C-u>zz', { desc = 'page up' })
map('v', '<PageUp>', '<C-u>zz', { desc = 'page up' })
map('i', '<PageUp>', '<C-o><C-u><C-o>zz', { desc = 'page up' })

-- do stuff without overwriting the previous clipboard (e.g. for replacing marked text)
map('v', 'p', '"_dP', { desc = 'paste' })
map('n', '<leader>d', '"_d', { desc = 'delete without yank' })
map('v', '<leader>d', '"_d', { desc = 'delete without yank' })

-- replace the word under the cursor
map('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>',
    { silent = false, desc = 'replace word under cursor' })

-- select pasted text
map('n', 'gv', '`[v`]', { desc = 'reselect previous selection/paste' })

-- redo with Shift+u
map('n', 'U', ':redo<CR>', { desc = 'redo' })

-- CTRL motions
map('n', '<C-Up>', '10<Up>', { desc = '10 up' })
map('v', '<C-Up>', '10<Up>', { desc = '10 up' })
map('i', '<C-Up>', '<C-o>10<Up>', { desc = '10 up' })
map('n', '<C-Down>', '10<Down>', { desc = '10 down' })
map('v', '<C-Down>', '10<Down>', { desc = '10 down' })
map('i', '<C-Down>', '<C-o>10<Down>', { desc = '10 down' })
map('n', '<C-Left>', 'b', { desc = '1 word back' })
map('v', '<C-Left>', 'b', { desc = '1 word back' })
map('i', '<C-Left>', '<C-o>b', { desc = '1 word back' })
map('n', '<C-Right>', 'w', { desc = '1 word forward' })
map('v', '<C-Right>', 'w', { desc = '1 word forward' })
map('i', '<C-Right>', '<C-o>w', { desc = '1 word forward' })

-- q for word back is easier
map('n', 'q', 'b', { desc = '1 word back' })
map('v', 'q', 'b', { desc = '1 word back' })
map('n', 'Q', 'B', { desc = '1 word back' })
map('v', 'Q', 'B', { desc = '1 word back' })

-- ctrl+shift+w to delete to beginning of line
map('i', '<C-S-w>', '<C-u>', { desc = 'delete until start of line' })

-- clear highlighting
map('n', '<leader><Space>', ':noh<CR>', { desc = 'clear highlighting' })

-- access markers
map('n', 'gm', "'", { desc = 'go to markers' })
map('v', 'gm', "'", { desc = 'go to markers' })

-- toggle mouse
map('n', '<leader>m', function()
    local old_val = vim.opt.mouse:get()
    local is_a = old_val['a']
    local is_v = old_val['v']
    if is_v then
        vim.opt.mouse = 'a'
        print('mouse=a')
    elseif is_a then
        vim.opt.mouse = 'v'
        print('mouse=v')
    else
        print('will not toggle - mouse=', vim.inspect(old_val))
    end
end, { desc = 'toggle mouse' })

-- toggle expandtab
map('n', '<leader><tab>', function()
    local new_val = not (vim.opt.expandtab:get())
    vim.opt.expandtab = new_val
    print('expandtab (replace tab with spaces) set to ' .. (new_val and "true" or "false"))
end, { desc = 'toggle expandtab' })

-- toggle gutters
map('n', '<leader>1', function()
    local new_val = not (vim.opt.relativenumber:get())
    vim.opt.number = new_val
    vim.opt.relativenumber = new_val
    vim.opt.signcolumn = new_val and 'yes' or 'no'
    vim.opt.foldcolumn = new_val and '1' or '0'
    print('gutters are now ' .. (new_val and "shown" or "hidden"))
end, { desc = 'toggle gutters' })

-- toggle diagnostic
map('n', 'ge', function() vim.diagnostic.open_float(0, { scope = "line" }) end,
    { desc = 'show error diagnostic for current line' })

-- next/prev diagnostic
map('n', 'gn', vim.diagnostic.goto_next, { desc = 'next diagnostic' })
map('n', 'gp', vim.diagnostic.goto_next, { desc = 'prev diagnostic' })
