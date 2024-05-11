-- condition to not load in vscode
local no_vscode = function()
    return vim.g.vscode == nil
end

-- ensure the packer plugin manager is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    --------------------
    -- LSP and other stuff
    --------------------

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        as = 'treesitter',
        run = ':TSUpdate',
        config = require('configs/config_treesitter')
    }

    ---- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        cond = no_vscode,
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            -- additional completion
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-buffer' },
            { 'andersevenrud/cmp-tmux' },

            -- better code action menu
            {
                'weilbith/nvim-code-action-menu',
                cmd = 'CodeActionMenu',
                cond = no_vscode,
            },

            -- nice symbols for cmp completion menu
            {
                'onsails/lspkind.nvim',
                cond = no_vscode,
            },

            -- inlay hints
            {
                'lvimuser/lsp-inlayhints.nvim',
                cond = no_vscode,
            },

            -- show progress
            {
                'j-hui/fidget.nvim',
                cond = no_vscode,
                tag = 'legacy',
            }
        },
    }


    --------------------
    -- Appearance
    --------------------

    -- color theme
    use { 'navarasu/onedark.nvim',
        as = 'onedark',
        cond = no_vscode,
        config = function()
            require('onedark').setup {
                style = 'deep',
                transparent = true,
            }
            require('onedark').load()
        end
    }

    -- status bar
    use {
        'freddiehaddad/feline.nvim',
        cond = no_vscode,
        requires = { 'nvim-tree/nvim-web-devicons', opt = false },
        config = require('configs/config_feline')
    }

    -- show current context when out of visible range
    use {
        "nvim-treesitter/nvim-treesitter-context",
        cond = no_vscode,
        config = function()
            vim.keymap.set('n', '<leader>2', ':TSContextToggle<CR>',
                { noremap = true, silent = true, desc = "Toggle treesitter-context" })
        end
    }

    -- nicer folding
    use {
        'kevinhwang91/nvim-ufo',
        cond = no_vscode,
        requires = {
            'kevinhwang91/promise-async',
            "luukvbaal/statuscol.nvim", -- remove pesky foldlevel numbers from foldcolumn
        },
        config = require('configs/config_ufo')
    }

    -- nicer nvim ui
    use { 'stevearc/dressing.nvim',
        cond = no_vscode,
    }

    -- nicer highlight of braces, keywords, ...
    use {
        'andymass/vim-matchup',
        setup = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
            require 'nvim-treesitter.configs'.setup { matchup = { enable = true } }
        end
    }

    -- nicer notifications
    use {
        'rcarriga/nvim-notify',
        cond = no_vscode,
        requires = { 'nvim-telescope/telescope.nvim' },
    }

    -- show help menu
    use { "folke/which-key.nvim",
        cond = no_vscode,
        config = require('configs/config_which-key')
    }

    -- sidebar for quick code navigation
    use { 'stevearc/aerial.nvim',
        cond = no_vscode,
        config = require('configs/config_aerial')
    }

    -- view for errors/warnings/info
    use {
        "folke/trouble.nvim",
        cond = no_vscode,
        requires = "nvim-tree/nvim-web-devicons",
        config = require('configs/config_trouble')
    }

    -- nicer file explorer
    use { 'stevearc/oil.nvim',
        cond = no_vscode,
        config = require('configs/config_oil')
    }

    -- git
    use {
        'lewis6991/gitsigns.nvim',
        cond = no_vscode,
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
        config = require('configs/config_gitsigns'),
    }
    use { 'tpope/vim-fugitive',
        cond = no_vscode,
        config = require('configs/config_fugitive'),
    }

    -- easier windows moving
    use { 'sindrets/winshift.nvim',
        cond = no_vscode,
        config = require('configs/config_winshift'),
    }

    -- easier windows resizing
    use { 'mrjones2014/smart-splits.nvim',
        cond = no_vscode,
        config = require('configs/config_smart-splits')
    }


    --------------------
    -- Motions
    --------------------

    -- add 'surround' motion
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- subword movement with w, e, b
    use {
        "chrisgrieser/nvim-spider",
        config = function()
            local modes = { 'n', 'x' }
            local spider = require('spider')
            vim.keymap.set(modes, 'w', function() spider.motion('w') end)
            vim.keymap.set(modes, 'e', function() spider.motion('e') end)
            vim.keymap.set(modes, 'b', function() spider.motion('b') end)
            vim.keymap.set(modes, 'q', function() spider.motion('b') end)
        end
    }

    -- additional targets
    use 'wellle/targets.vim' -- 'change inside' e.g. for '_', '|', ...


    --------------------
    -- Editing Convenience
    --------------------

    -- undo
    use { 'mbbill/undotree',
        cond = no_vscode,
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'toggle undo tree' })
        end,
    }

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        cond = no_vscode,
        requires = { { 'nvim-lua/plenary.nvim' } },
    }

    -- snippets
    use {
        "L3MON4D3/LuaSnip",
        cond = no_vscode,
        tag = "v2.*",                 -- follow latest release.
        run = "make install_jsregexp" -- install jsregexp (optional!:).
    }
    use {
        "rafamadriz/friendly-snippets",
        cond = no_vscode,
    }

    -- jump around, jump around, jump up jump up and get down
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
    }

    -- toggle comments
    use { 'numToStr/Comment.nvim',
        cond = no_vscode,
        config = require('configs/config_comment'),
    }

    -- automatically close brackets when opening them
    use { 'windwp/nvim-autopairs',
        config = require('configs/config_autopairs')
    }

    -- cumulative increment in visual mode
    use {
        'https://github.com/triglav/vim-visual-increment',
        config = function()
            -- keymap has to be set before plugin is loaded, otherwise default keymaps will be overwritten
            vim.keymap.set('v', '<leader><C-a>', '<Plug>VisualIncrement', { desc = 'cumulative increment' })
            vim.keymap.set('v', '<leader><C-x>', '<Plug>VisualDecrement', { desc = 'cumulative decrement' })
        end
    }

    -- better register handling
    use {
        'gennaro-tedesco/nvim-peekup',
        cond = no_vscode,
        config = function()
            -- menu with '""'
            vim.keymap.set('n', '<leader>"p', '<Plug>PeekupPasteAfter', { desc = 'paste register after cursor' })
            vim.keymap.set('n', '<leader>"P', '<Plug>PeekupPasteBefore', { desc = 'paste register before cursor' })
        end
    }

    -- sudo saving
    use {
        'https://github.com/lambdalisue/suda.vim',
        cond = no_vscode,
        config = function()
            vim.api.nvim_create_user_command('W', 'SudaWrite', {})
        end
    }

    -- text alignment
    use { 'echasnovski/mini.align',
        branch = 'stable',
        config = function()
            require('mini.align').setup()
        end
    }


    --------------------
    -- File specific
    --------------------

    -- markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })


    --------------------
    -- Performance
    --------------------

    -- NOTE: this section should come last, as stuff might be overridden

    -- faster coloring
    use {
        'NvChad/nvim-colorizer.lua',
        cond = no_vscode,
        config = function()
            require('colorizer').setup()
        end
    }
end)

-- the first run will install packer and our plugins
if packer_bootstrap then
    require("packer").sync()
    return
end
