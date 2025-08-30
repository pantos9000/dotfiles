local jump_to_word_beginning = function()
  require("flash").jump {
    search = {
      mode = function(str) return "\\<" .. str end,
    },
  }
end

local show_diagnostic = function()
  require("flash").jump {
    action = function(match, state)
      vim.api.nvim_win_call(match.win, function()
        vim.api.nvim_win_set_cursor(match.win, match.pos)
        vim.diagnostic.open_float()
      end)
      state:restore()
    end,
  }
end

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "<Tab>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<CR>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    { "<S-Tab>", mode = { "n", "x", "o" }, function() show_diagnostic() end, desc = "Flash" },
  },
  opts = {
    label = {
      uppercase = false,
      after = true,
      before = true,
    },
    modes = {
      char = {
        -- use labels with t, f
        jump_labels = false,
      },
    },
  },
}
