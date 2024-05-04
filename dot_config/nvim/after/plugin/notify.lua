if vim.g.vscode ~= nil then
    return
end

local notify = require('notify')
notify.setup({
    stages = 'slide',
    background_colour = 'FloatShadow',
    timeout = 3000,
})
vim.notify = notify

local telescope = require('telescope')
telescope.load_extension('notify')
