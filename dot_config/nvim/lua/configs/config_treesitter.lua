local M = function()
    require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "help", "c", "rust", "python", "lua", "vim", "vimdoc", "query" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "help" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- disable = { "c", "rust" },

            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(lang, buf)
                local max_filesize = 10 * 1024 * 1024 -- 10 MB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },

        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = { query = "@function.outer", desc = "Select outer part of function" },
                    ["if"] = { query = "@function.inner", desc = "Select inner part of function" },
                    ["ac"] = { query = "@class.outer"   , desc = "Select outer part of class" },
                    ["ic"] = { query = "@class.inner"   , desc = "Select inner part of class" },
                    ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                },
            },
        },
    }

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.d2 = {
        install_info = {
            url = 'https://github.com/pleshevskiy/tree-sitter-d2',
            revision = 'main',
            files = { 'src/parser.c', 'src/scanner.cc' },
        },
        filetype = 'd2',
    };
end

return M
