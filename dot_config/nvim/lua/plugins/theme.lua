return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "onedark",
    },
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup {
        style = "deep",
        transparent = true,
      }
      require("notify").setup {
        background_colour = "#000000",
      }
    end,
  },
}
