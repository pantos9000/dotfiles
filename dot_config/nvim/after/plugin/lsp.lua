local lsp = require('lsp-zero').preset({
    name = 'recommended',

})

-- some lsp-buffer specific keybindings
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr }) -- add lsp-zero defaults

    local function map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true, buffer = bufnr }
        if opts then
            options = vim.tbl_extend('force', options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
    end

    -- go to *
    map('n', 'gd', function() vim.lsp.buf.definition() end, { desc = 'go to definition' })
    map('n', 'gD', function() vim.lsp.buf.declaration() end, { desc = 'go to declaration' })
    map('n', 'gt', function() vim.lsp.buf.type_definition() end, { desc = 'go to type definition' })
    map('n', 'gr', function() vim.lsp.buf.references() end, { desc = 'go to reference' })
    map('n', 'gi', function() vim.lsp.buf.implementation() end, { desc = 'go to implementation' })

    map('n', 'gq', function() vim.lsp.buf.workspace_symbol() end, { desc = 'query symbols' })
    map('n', 'gh', function() vim.lsp.buf.hover() end, { desc = 'hover' })
    map('n', 'gs', function() vim.lsp.buf.signature_help() end, { desc = 'signature help' })

    -- map('n', 'ga', function() vim.lsp.buf.code_action() end, { desc = 'code action' })
    map('n', 'ga', vim.cmd.CodeActionMenu, { desc = 'code action' })
    map('n', 'F2', function() vim.lsp.buf.rename() end, { desc = 'rename symbol under cursor' })
    map('n', 'F3', function() vim.lsp.buf.format() end, { desc = 'format file' })
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

lsp.setup()

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    completion = {
        keyword_length = 0,
        autocomplete = false,
    },
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- allow arrow keys to go through the list
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),

        -- Navigate between snippet placeholder
        --['<C-f>'] = cmp_action.luasnip_jump_forward(),
        --['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})
