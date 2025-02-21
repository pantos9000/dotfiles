-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {
        -- absolute/relative line numbers
        number = true,
        relativenumber = false,

        -- display tabs and EOL spaces
        list = true,
        listchars = {
          lead = '·',
          trail = '·',
          tab = '▸ ',
          extends = '⮞',
          precedes = '⮜',
          -- nbsp = '·',
          -- eol = '¬',
        },
        --vim.cmd([[highlight Whitespace ctermfg=darkcyan guifg=darkcyan]])

        -- tabstop
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
        expandtab = true,

        smartindent = true,
        sidescroll = 1,

        -- use undofiles instead of swapfiles
        swapfile = false,
        backup = false,
        --undodir = os.getenv("HOME") .. "/.cache/nvim/undodir",
        undofile = true,

        -- incremental search
        hlsearch = true,
        incsearch = true,

        -- ignore case if only lowercase pattern
        ignorecase = true,
        smartcase = true,

        -- use 24-bit RGB color
        termguicolors = true,

        -- min # of lines to show before/after cursor
        scrolloff = 10,
        sidescrolloff = 15,

        -- always show gutter
        signcolumn = "yes",

        -- show line-break column on the right
        colorcolumn = "100",

        -- disable modelines
        modeline = false,

        -- only enable mouse in visual and normal mode (for mark&copy in other modes)
        mouse = 'nv',

        -- auto reload changed files
        autoread = true,

        -- use system clipboard by default
        clipboard = 'unnamedplus',

        -- UTF-8 FTW \o/
        encoding = 'utf-8',

        -- disable spell checking
        spell = false,

        -- wrap lines
        wrap = true,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
  },
}
