return {
    {
        'sindrets/winshift.nvim',
        config = function()
            -- mappings
            vim.keymap.set('n', '<C-w>m', '<cmd> WinShift<CR>', { noremap = true, silent = true, desc = 'move windows' })

            require("winshift").setup({
                highlight_moving_win = true, -- Highlight the window being moved
                focused_hl_group = "Visual", -- The highlight group used for the moving window
                moving_win_options = {
                    -- These are local options applied to the moving window while it's
                    -- being moved. They are unset when you leave Win-Move mode.
                    wrap = false,
                    cursorline = false,
                    cursorcolumn = false,
                    colorcolumn = "",
                },
                keymaps = {
                    disable_defaults = false, -- Disable the default keymaps
                    win_move_mode = {
                        ["<left>"] = "left",
                        ["<down>"] = "down",
                        ["<up>"] = "up",
                        ["<right>"] = "right",
                        ["<S-left>"] = "far_left",
                        ["<S-down>"] = "far_down",
                        ["<S-up>"] = "far_up",
                        ["<S-right>"] = "far_right",
                    },
                },

                ---A function that should prompt the user to select a window.
                ---
                ---The window picker is used to select a window while swapping windows with
                ---`:WinShift swap`.
                ---@return integer? winid # Either the selected window ID, or `nil` to
                ---   indicate that the user cancelled / gave an invalid selection.
                window_picker = function()
                    return require("winshift.lib").pick_window({
                        -- A string of chars used as identifiers by the window picker.
                        picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                        filter_rules = {
                            -- This table allows you to indicate to the window picker that a window
                            -- should be ignored if its buffer matches any of the following criteria.
                            cur_win = true, -- Filter out the current window
                            floats = true, -- Filter out floating windows
                            filetype = {}, -- List of ignored file types
                            buftype = {}, -- List of ignored buftypes
                            bufname = {}, -- List of vim regex patterns matching ignored buffer names
                        },
                        ---A function used to filter the list of selectable windows.
                        ---@param winids integer[] # The list of selectable window IDs.
                        ---@return integer[] filtered # The filtered list of window IDs.
                        filter_func = nil,
                    })
                end,
            })
        end,
    },
    {
        config = function()
            local ss = require('smart-splits')

            local function map(mode, lhs, rhs, opts)
                local options = { noremap = true, silent = true }
                if opts then
                    options = vim.tbl_extend('force', options, opts)
                end
                vim.keymap.set(mode, lhs, rhs, options)
            end

            map('n', '<C-w>r', ss.start_resize_mode, { desc = 'resize mode' })

            ss.setup({
                -- Ignored filetypes (only while resizing)
                ignored_filetypes = {
                    'nofile',
                    'quickfix',
                    'qf',
                    'prompt',
                },
                -- Ignored buffer types (only while resizing)
                ignored_buftypes = { 'NvimTree', 'nofile' },
                -- the default number of lines/columns to resize by at a time
                default_amount = 3,
                -- Desired behavior when your cursor is at an edge and you
                -- are moving towards that same edge:
                -- 'wrap' => Wrap to opposite side
                -- 'split' => Create a new split in the desired direction
                -- 'stop' => Do nothing
                -- function => You handle the behavior yourself
                -- NOTE: If using a function, the function will be called with
                -- a context object with the following fields:
                -- {
                --    mux = {
                --      type:'tmux'|'wezterm'|'kitty'
                --      current_pane_id():number,
                --      is_in_session(): boolean
                --      current_pane_is_zoomed():boolean,
                --      -- following methods return a boolean to indicate success or failure
                --      current_pane_at_edge(direction:'left'|'right'|'up'|'down'):boolean
                --      next_pane(direction:'left'|'right'|'up'|'down'):boolean
                --      resize_pane(direction:'left'|'right'|'up'|'down'):boolean
                --      split_pane(direction:'left'|'right'|'up'|'down',size:number|nil):boolean
                --    },
                --    direction = 'left'|'right'|'up'|'down',
                --    split(), -- utility function to split current Neovim pane in the current direction
                --    wrap(), -- utility function to wrap to opposite Neovim pane
                -- }
                -- NOTE: `at_edge = 'wrap'` is not supported on Kitty terminal
                -- multiplexer, as there is no way to determine layout via the CLI
                at_edge = 'wrap',
                -- when moving cursor between splits left or right,
                -- place the cursor on the same row of the *screen*
                -- regardless of line numbers. False by default.
                -- Can be overridden via function parameter, see Usage.
                move_cursor_same_row = false,
                -- whether the cursor should follow the buffer when swapping
                -- buffers by default; it can also be controlled by passing
                -- `{ move_cursor = true }` or `{ move_cursor = false }`
                -- when calling the Lua function.
                cursor_follows_swapped_bufs = false,
                -- resize mode options
                resize_mode = {
                    -- key to exit persistent resize mode
                    quit_key = '<ESC>',
                    -- keys to use for moving in resize mode
                    -- in order of left, down, up' right
                    resize_keys = { '<Left>', '<Down>', '<Up>', '<Right>' },
                    -- set to true to silence the notifications
                    -- when entering/exiting persistent resize mode
                    silent = false,
                    -- must be functions, they will be executed when
                    -- entering or exiting the resize mode
                    hooks = {
                        on_enter = nil,
                        on_leave = nil,
                    },
                },
                -- ignore these autocmd events (via :h eventignore) while processing
                -- smart-splits.nvim computations, which involve visiting different
                -- buffers and windows. These events will be ignored during processing,
                -- and un-ignored on completed. This only applies to resize events,
                -- not cursor movement events.
                ignored_events = {
                    'BufEnter',
                    'WinEnter',
                },
                -- enable or disable a multiplexer integration;
                -- automatically determined, unless explicitly disabled or set,
                -- by checking the $TERM_PROGRAM environment variable,
                -- and the $KITTY_LISTEN_ON environment variable for Kitty
                multiplexer_integration = nil,
                -- disable multiplexer navigation if current multiplexer pane is zoomed
                -- this functionality is only supported on tmux and Wezterm due to kitty
                -- not having a way to check if a pane is zoomed
                disable_multiplexer_nav_when_zoomed = true,
                -- Supply a Kitty remote control password if needed,
                -- or you can also set vim.g.smart_splits_kitty_password
                -- see https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.remote_control_password
                kitty_password = nil,
                -- default logging level, one of: 'trace'|'debug'|'info'|'warn'|'error'|'fatal'
                log_level = 'info',
            })
        end,'mrjones2014/smart-splits.nvim',
    }
}
