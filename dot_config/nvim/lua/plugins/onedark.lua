return {
  "navarasu/onedark.nvim",
  config = function()
    require("onedark").setup {
      style = "deep",
      transparent = true,
    }
    require("onedark").load()
    require("notify").setup {
      background_colour = "#000000",
    }
  end,
}
