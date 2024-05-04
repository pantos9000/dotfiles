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

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        as = 'treesitter',
        run = ':TSUpdate'
    }

    -- snippets
    use {
        "L3MON4D3/LuaSnip",
        tag = "v2.*",                 -- follow latest release.
        run = "make install_jsregexp" -- install jsregexp (optional!:).
    }
    use {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    }

    ---- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
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
            },

            -- nice symbols for cmp completion menu
            { 'onsails/lspkind.nvim' },

            -- inlay hints
            { 'lvimuser/lsp-inlayhints.nvim' },

            -- show progress
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
            }
        }
    }

    -- color theme
    use { 'navarasu/onedark.nvim',
        as = 'onedark',
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
        requires = { 'nvim-tree/nvim-web-devicons', opt = false }
    }

    -- nicer folding
    use {
        'kevinhwang91/nvim-ufo',
        requires = {
            'kevinhwang91/promise-async',
            "luukvbaal/statuscol.nvim", -- remove pesky foldlevel numbers from foldcolumn
        }
    }

    -- nicer nvim ui
    use { 'stevearc/dressing.nvim' }

    -- nicer notifications
    use {
        'rcarriga/nvim-notify',
        requires = { 'nvim-telescope/telescope.nvim' },
    }

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- undo
    use 'mbbill/undotree'

    -- show help menu
    use "folke/which-key.nvim"

    -- git
    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }
    use 'tpope/vim-fugitive'

    -- jump around, jump around, jump up jump up and get down
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        -- config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        -- require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        -- end
    }

    -- toggle comments
    use 'numToStr/Comment.nvim'

    -- automatically close brackets when opening them
    use 'windwp/nvim-autopairs'

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

    -- treesitter targets
    use 'RRethy/nvim-treesitter-textsubjects'

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
        config = function()
            vim.keymap.set('n', '<leader>"p', '<Plug>PeekupPasteAfter', { desc = 'paste register after cursor' })
            vim.keymap.set('n', '<leader>"P', '<Plug>PeekupPasteBefore', { desc = 'paste register before cursor' })
        end
    }

    -- sudo saving
    use {
        'https://github.com/lambdalisue/suda.vim',
        config = function()
            vim.api.nvim_create_user_command('W', 'SudaWrite', {})
        end
    }

    -- view for errors/warnings/info
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
    }

    -- nicer file explorer
    use { 'stevearc/oil.nvim' }

    -- neo org mode
    use {
        "nvim-neorg/neorg",
        ft = "norg",   -- only load in norg files
        cmd = 'Neorg', -- lazy load on command, allows you to autocomplete :Neorg regardless of whether it's loaded yet
        config = function()
            require('neorg').setup { load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.integrations.nvim-cmp"] = {},
                ["core.concealer"] = { -- Adds pretty icons to your documents
                    config = { icon_preset = "varied" }
                },
                ["core.export"] = {},
                ["core.presenter"] = {
                    config = { zen_mode = "zen-mode" }
                },
                ["core.keybinds"] = { config = {
                    -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
                    default_keybinds = false,
                    neorg_leader = "<leader>t",
                    hook = function(keybinds)
                        local leader = keybinds.leader
                        local ni_map = {
                            {
                                "<S-Left>",
                                "core.promo.demote",
                                "nested",
                                opts = {
                                    desc = "Demote Object" }
                            },
                            {
                                "<S-Right>",
                                "core.promo.promote",
                                "nested",
                                opts = {
                                    desc = "Promote Object" }
                            },
                            {
                                "<C-Up>",
                                "core.integrations.treesitter.previous.heading",
                                opts = {
                                    desc = "Move to prev heading" }
                            },
                            {
                                "<C-Down>",
                                "core.integrations.treesitter.next.heading",
                                opts = {
                                    desc = "Move to next heading" }
                            },
                        }
                        keybinds.map_event_to_mode("norg", {
                            n = ni_map,
                            i = ni_map,
                        }, {
                            silent = true,
                            noremap = false,
                            nowait = true,
                        })
                        keybinds.map_event_to_mode("norg", {
                            n = {
                                {
                                    leader .. "u",
                                    "core.qol.todo_items.todo.task_undone",
                                    opts = {
                                        desc = "Mark as undone" }
                                },
                                {
                                    leader .. "p",
                                    "core.qol.todo_items.todo.task_pending",
                                    opts = {
                                        desc = "Mark as pening" }
                                },
                                {
                                    leader .. "d",
                                    "core.qol.todo_items.todo.task_done",
                                    opts = {
                                        desc = "Mark as done" }
                                },
                                {
                                    leader .. "h",
                                    "core.qol.todo_items.todo.task_on_hold",
                                    opts = {
                                        desc = "Mark as on hold" }
                                },
                                {
                                    leader .. "c",
                                    "core.qol.todo_items.todo.task_cancelled",
                                    opts = {
                                        desc = "Mark as cancelled" }
                                },
                                {
                                    leader .. "r",
                                    "core.qol.todo_items.todo.task_recurring",
                                    opts = {
                                        desc = "Mark as recurring" }
                                },
                                {
                                    leader .. "i",
                                    "core.qol.todo_items.todo.task_important",
                                    opts = {
                                        desc = "Mark as important" }
                                },
                                {
                                    leader .. "l",
                                    "core.pivot.toggle-list-type",
                                    opts = {
                                        desc = "Toggle (un)ordered list" }
                                },
                                {
                                    leader .. "L",
                                    "core.pivot.invert-list-type",
                                    opts = {
                                        desc = "Invert (un)ordered list" }
                                },
                                { "<CR>", "core.esupports.hop.hop-link", opts = { desc = "Jump to Link" } },
                                {
                                    "gd",
                                    "core.esupports.hop.hop-link",
                                    opts = { desc = "Jump to Link (Vertical Split)" },
                                },
                                {
                                    "gD",
                                    "core.esupports.hop.hop-link",
                                    "vsplit",
                                    opts = { desc = "Jump to Link (Vertical Split)" },
                                },
                            },
                        }, {
                            silent = true,
                            noremap = false,
                        })
                        keybinds.map_to_mode("norg", {
                            n = {
                                {
                                    leader .. "t",
                                    ":Neorg toggle-concealer<CR>",
                                    opts = {
                                        desc = "Toggle concealer" }
                                },
                                {
                                    leader .. "a",
                                    ":Neorg toc split<CR>",
                                    opts = { desc = "Open table of contents" }
                                },
                            }
                        })
                        keybinds.map_event_to_mode("presenter", {
                            n = {
                                { "<CR>",    "core.presenter.next_page",     opts = { desc = "Next Page" } },
                                { "<Right>", "core.presenter.next_page",     opts = { desc = "Next Page" } },
                                { "<Left>",  "core.presenter.previous_page", opts = { desc = "Previous Page" } },

                                -- Keys for closing the current display
                                { "q",       "core.presenter.close",         opts = { desc = "Close Presentation" } },
                                { "<Esc>",   "core.presenter.close",         opts = { desc = "Close Presentation" } },
                            },
                        }, {
                            silent = true,
                            noremap = true,
                            nowait = true,
                        })
                    end,
                }, },
            }, }
        end,
        run = ":Neorg sync-parsers",
        requires = {
            "nvim-lua/plenary.nvim",
            "folke/zen-mode.nvim",
        },
    }

    -- sidebar for quick code navigation
    use 'stevearc/aerial.nvim'

    -- easier windows moving
    use 'sindrets/winshift.nvim'

    -- easier windows resizing
    use 'mrjones2014/smart-splits.nvim'

    -- text alignment
    use { 'echasnovski/mini.align', branch = 'stable' }

    -- faster coloring
    use {
        'NvChad/nvim-colorizer.lua',
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
