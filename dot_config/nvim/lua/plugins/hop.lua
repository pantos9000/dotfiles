return {
  "phaazon/hop.nvim",
  branch = "v2", -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require("hop").setup { keys = "etovxqpdygfblzhckisuran" }

    local hop = require "hop"

    -- jump to word
    vim.keymap.set({ "n", "v" }, "<Tab>", hop.hint_words, { remap = true, desc = "jump to word" })

    -- jump to char
    vim.keymap.set({ "n", "v" }, "<S-Tab>", hop.hint_lines_skip_whitespace, { remap = true, desc = "jump to char" })

    -- insert mode
    vim.keymap.set("i", "<C-j>", "<C-o>j", { remap = true, desc = "jump to word (insert mode)" })
    vim.keymap.set("i", "<C-k>", "<C-o>k", { remap = true, desc = "jump to char (insert mode)" })
  end,
}
