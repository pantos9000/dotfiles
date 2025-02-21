-- move inside subwords with w, e, b
return {
  "chrisgrieser/nvim-spider",
  config = function()
    vim.keymap.set({ "n", "o", "x" }, "w", function() require("spider").motion "w" end, { desc = "Spider-w" })
    vim.keymap.set({ "n", "o", "x" }, "e", function() require("spider").motion "e" end, { desc = "Spider-e" })
    vim.keymap.set({ "n", "o", "x" }, "b", function() require("spider").motion "b" end, { desc = "Spider-b" })
    vim.keymap.set({ "n", "o", "x" }, "q", function() require("spider").motion "b" end, { desc = "Spider-b" })
    vim.keymap.set("n", "cw", "c<cmd>lua require('spider').motion('e')<CR>")
    vim.keymap.set("n", "vw", "v<cmd>lua require('spider').motion('e')<CR>")
    vim.keymap.set("n", "yw", "y<cmd>lua require('spider').motion('e')<CR>")
  end,
}
