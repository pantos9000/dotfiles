if vim.g.vscode ~= nil then
    return
end

local inlay_hints = require('lsp-inlayhints')
-- for defaults see:
-- https://github.com/simrat39/inlay-hints.nvim/blob/main/lua/inlay-hints/config.lua
inlay_hints.setup({
    only_current_line = false,
    eol = {
        right_align = false,
    },
})

local lsp = require('lsp-zero')
lsp.preset({
    name = 'recommended',
    manage_nvim_cmp = false,
})

lsp.on_attach(function(client, bufnr)
    local telescope = require('telescope.builtin')
    inlay_hints.on_attach(client, bufnr)

    lsp.default_keymaps({ buffer = bufnr }) -- add lsp-zero defaults

    local function map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true, buffer = bufnr }
        if opts then
            options = vim.tbl_extend('force', options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
    end

    -- go to *
    map('n', 'gd', telescope.lsp_definitions, { desc = 'go to definition' })
    map('n', 'gD', vim.lsp.buf.declaration, { desc = 'go to declaration' })
    map('n', 'gi', telescope.lsp_implementations, { desc = 'go to implementation' })
    map('n', 'gt', telescope.lsp_type_definitions, { desc = 'go to type definition' })
    map('n', 'gr', telescope.lsp_references, { desc = 'list references' })
    map('n', 'gc', telescope.lsp_incoming_calls, { desc = 'go to incoming calls' })
    map('n', 'gC', telescope.lsp_outgoing_calls, { desc = 'go to outgoing calls' })

    map('n', 'gs', telescope.lsp_dynamic_workspace_symbols, { desc = 'query symbols' })
    map('n', 'gh', vim.lsp.buf.hover, { desc = 'hover' })
    map('n', '<C-h>', vim.lsp.buf.signature_help, { desc = 'signature help' })
    map('i', '<C-h>', vim.lsp.buf.signature_help, { desc = 'signature help' })

    map('n', 'ga', vim.cmd.CodeActionMenu, { desc = 'code action' })
    map('v', 'ga', vim.cmd.CodeActionMenu, { desc = 'code action' })

    map('n', '<leader>r', vim.lsp.buf.rename, { desc = 'rename symbol under cursor' }) -- TODO change
    map('n', '<F3>', vim.lsp.buf.format, { desc = 'format file' })

    map('n', '<leader>h', inlay_hints.toggle, { desc = 'toggle inlay hints' })
end)

-- format on save
lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        ['pylsp'] = { 'python' },
        ['neocmake'] = { 'cmake' },
        ['clangd'] = { 'c', 'cpp', 'cs', 'cuda' },
        -- if you have a working setup with null-ls
        -- you can specify filetypes it can format.
        -- ['null-ls'] = {'javascript', 'typescript'},
    }
})

-- required language servers
lsp.ensure_installed({
    'lua_ls',
    'rust_analyzer',
    'pylsp',
    'tsserver',
    'eslint',
    'clangd',
    'neocmake',
    'bashls',
})

lsp.setup()

-- setup `cmp` after lsp-zero
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
    completion = {
        keyword_length = 0,
        autocomplete = false,
    },
    formatting = {
        format = lspkind.cmp_format({
            -- defines how annotations are shown
            -- default: symbol
            -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            mode = 'symbol',
        })
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- allow arrow keys to go through the list
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    },
    sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "neorg",    priority = 600 },
        { name = "buffer",   priority = 500 },
        { name = "tmux",     priority = 300 },
        { name = "path",     priority = 250 },
    },
})

vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
    config = config or {}
    config.focus_id = ctx.method
    if not (result and result.contents) then
        return
    end
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
    if vim.tbl_isempty(markdown_lines) then
        return
    end
    return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
end
