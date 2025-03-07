-- move inside subwords with w, e, b
return {
  "chrisgrieser/nvim-spider",
  config = function()
    vim.keymap.set({ "n", "o", "x" }, "W", function() require("spider").motion "w" end, { desc = "Spider-w" })
    vim.keymap.set({ "n", "o", "x" }, "E", function() require("spider").motion "e" end, { desc = "Spider-e" })
    vim.keymap.set({ "n", "o", "x" }, "B", function() require("spider").motion "b" end, { desc = "Spider-b" })
    vim.keymap.set({ "n", "o", "x" }, "Q", function() require("spider").motion "b" end, { desc = "Spider-b" })
  end,
}
