return {
  "aznhe21/actions-preview.nvim",
  config = function()
    require("actions-preview").setup {
      highlight_command = {

        require("actions-preview.highlight").delta(),
      },
    }

    vim.keymap.set("n", "ga", require("actions-preview").code_actions, { desc = "code action" })
    vim.keymap.set("v", "ga", require("actions-preview").code_actions, { desc = "code action" })
    vim.keymap.set("n", "<C-.>", require("actions-preview").code_actions, { desc = "code action" })
    vim.keymap.set("v", "<C-.>", require("actions-preview").code_actions, { desc = "code action" })
    vim.keymap.set("i", "<C-.>", require("actions-preview").code_actions, { desc = "code action" })
  end,
}
