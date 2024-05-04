if not packer_plugins['notify'] or not packer_plugins['notify'].loaded then
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
