local M = function()
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
                                        desc = "Mark as pending" }
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
                                    { desc = "Toggle concealer" }
                                },
                                {
                                    leader .. "a",
                                    ":Neorg toc split<CR>",
                                    { desc = "Open table of contents" }
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
end

return M
