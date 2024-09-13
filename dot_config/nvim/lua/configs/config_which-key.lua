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
            no_overlap = false,
            border = 'single', -- none, single, double, shadow
            padding = { 0, 0 },
        },
    }
end

return M
