local inlay_hints = require('lsp-inlayhints')
-- for defaults see:
-- https://github.com/simrat39/inlay-hints.nvim/blob/main/lua/inlay-hints/config.lua
inlay_hints.setup({
    only_current_line = false,
    eol = {
        right_align = false,
    },
})

local lsp = require('lsp-zero').preset({
    name = 'recommended',
    manage_nvim_cmp = false,
})

-- some lsp-buffer specific keybindings
local telescope = require('telescope.builtin')
lsp.on_attach(function(client, bufnr)
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

    -- map('n', 'ga', function() vim.lsp.buf.code_action() end, { desc = 'code action' })
    map('n', 'ga', vim.cmd.CodeActionMenu, { desc = 'code action' })
    -- TODO nicer code action
    -- TODO code action range?

    map('n', 'F2', vim.lsp.buf.rename, { desc = 'rename symbol under cursor' })
    map('n', 'F3', vim.lsp.buf.format, { desc = 'format file' })

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
        -- if you have a working setup with null-ls
        -- you can specify filetypes it can format.
        -- ['null-ls'] = {'javascript', 'typescript'},
    }
})

-- required language servers
lsp.ensure_installed({
    'lua_ls',
    'rust_analyzer',
    'pyright',
    'tsserver',
    'eslint',
    'clangd',
})

-- rust-analyzer will be setup by rust-tools
-- lsp.skip_server_setup({ 'rust-analyzer' })

lsp.setup()

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')
cmp.setup({
    completion = {
        keyword_length = 0,
        autocomplete = false,
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
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
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
    },
})
