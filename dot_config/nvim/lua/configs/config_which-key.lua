local M = function()
    -- help is automatically opened upon timeout
    vim.opt.timeout = true
    vim.opt.timeoutlen = 500

    require('which-key').setup {
        keys = {
            scroll_down = '<Down>',
            scroll_up = '<Up>',
        },
        win = {
            border = 'single', -- none, single, double, shadow
            position = 'bottom',
            margin = { 1, 0, 1, 0 },
            padding = { 0, 0, 0, 0 },
            winblend = 0, -- transparency
        },
    }
end

return M
