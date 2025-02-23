-- https://docs.astronvim.com/configuration/customizing_plugins/
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map

          -- prev/next menus
          ["ö"] = { "[", remap = true, desc = "prev..." },
          ["ä"] = { "]", remap = true, desc = "next..." },

          -- navigate buffer tabs
          ["Ä"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["Ö"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

          -- mappings seen under group name "Buffer"
          ["<Leader>bd"] = {
            function()
              require("astroui.status.heirline").buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Close buffer from tabline",
          },

          -- tables with just a `desc` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { desc = "Buffers" },

          -- setting a mapping to false will disable it
          ["<C-S>"] = false,

          -- move with shift
          ["<S-Down>"] = { "V :m '>+1<CR>", desc = "move line down" },
          ["<S-Up>"] = { "V :m '<-2<CR>", desc = "move line up" },
          ["<S-Right>"] = { ">>", desc = "move line right" },
          ["<S-Left>"] = { "<<", desc = "move line left" },

          -- let cursor stay in the middle when doing search
          ["n"] = { "nzzzv", desc = "next search result" },
          ["N"] = { "Nzzzv", desc = "prev search result" },

          -- let cursor stay in the middle on PgUp/PgDn
          ["<PageDown>"] = { "<C-d>zz", desc = "page down" },
          ["<PageUp>"] = { "<C-u>zz", desc = "page up" },

          -- do stuff without overwriting the previous clipboard (e.g. for replacing marked text)
          ["<leader>d"] = { '"_d', desc = "delete without yank" },

          -- select pasted text
          ["gv"] = { "`[v`]", desc = "reselect previous selection/paste" },

          -- redo with Shift+u
          ["U"] = { ":redo<CR>", desc = "redo" },

          -- q for word back is easier
          ["q"] = { "b", desc = "1 word back" },
          ["Q"] = { "B", desc = "1 word back" },

          -- clear highlighting
          ["<leader><Space>"] = { ":noh<CR>", desc = "clear highlighting" },

          -- CTRL motions
          ["<C-Up>"] = { "{", desc = "block up" },
          ["<C-k>"] = { "{", desc = "block up" },
          ["<C-Down>"] = { "}", desc = "block down" },
          ["<C-j>"] = { "}", desc = "block down" },
          ["<C-Left>"] = { "b", desc = "1 word back" },
          ["<C-h>"] = { "b", desc = "1 word back" },
          ["<C-Right>"] = { "w", desc = "1 word forward" },
          ["<C-l>"] = { "w", desc = "1 word forward" },

          -- go forward/backward
          ["gb"] = { "<C-o>", desc = "go backward in history" },
          ["gf"] = { "<C-i>", desc = "go forward in history" },

          -- toggle diagnostic
          ["ge"] = {
            function() vim.diagnostic.open_float(nil, { scope = "line" }) end,
            desc = "show error diagnostic for current line",
          },

          -- map % to § for easier access
          ["§"] = { "%", desc = "jump to block beginning/end" },

          -- toggle expandtab
          ["<leader><tab>"] = {
            function()
              local new_val = not (vim.opt.expandtab:get())
              vim.opt.expandtab = new_val
              print("expandtab (replace tab with spaces) set to " .. (new_val and "true" or "false"))
            end,
            desc = "toggle expandtab",
          },

          -- toggle mouse
          ["<leader>m"] = {
            function()
              local old_val = vim.opt.mouse:get()
              local is_a = old_val["a"]
              local is_v = old_val["v"]
              if is_v then
                vim.opt.mouse = "a"
                print "mouse=a"
              elseif is_a then
                vim.opt.mouse = "v"
                print "mouse=v"
              else
                print("will not toggle - mouse=", vim.inspect(old_val))
              end
            end,
            desc = "toggle mouse",
          },

          -- toggle gutters
          ["<leader>1"] = {
            function()
              local new_val = not (vim.opt.number:get())
              vim.opt.number = new_val
              vim.opt.signcolumn = new_val and "yes" or "no"
              vim.opt.foldcolumn = new_val and "1" or "0"
              print("gutters are now " .. (new_val and "shown" or "hidden"))
            end,
            desc = "toggle gutters",
          },

          -- access markers
          ["gm"] = { "'", desc = "go to markers" },

          -- window controls
          -- <C-w>m is defined in winshift plugin
          ["<C-w>v"] = { "<cmd> split<CR>", noremap = false, desc = "vertical split" },
          ["<C-w>h"] = { "<cmd> vsplit<CR>", noremap = false, desc = "horizontal split" },

          -- toggle inlay hints
          ["<leader>i"] = {
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
            desc = "toggle inlay hints",
          },

          -- toggle comments
          ["<C-c>"] = { "gcc", remap = true, desc = "Toggle comment line" },
        },
        i = {
          -- move with shift
          ["<S-Down>"] = { "<C-o>V :m '>+1<CR>", desc = "move line down" },
          ["<S-Up>"] = { "<C-o>V :m '<-2<CR>", desc = "move line up" },
          ["<S-Left>"] = { "<C-o><<", desc = "move line left" },
          ["<S-Right>"] = { "<C-o>>>", desc = "move line right" },

          -- let cursor stay in the middle on PgUp/PgDn
          ["<PageDown>"] = { "<C-o><C-d><C-o>zz", desc = "page down" },
          ["<PageUp>"] = { "<C-o><C-u><C-o>zz", desc = "page up" },

          -- CTRL motions
          ["<C-Up>"] = { "<C-o>{", desc = "block up" },
          ["<C-k>"] = { "<C-o>{", desc = "block up" }, -- TODO does not work
          ["<C-Down>"] = { "<C-o>}", desc = "block down" },
          ["<C-j>"] = { "<C-o>}", desc = "block down" }, -- TODO does not work
          ["<C-Left>"] = { "<C-o>b", desc = "1 word back" },
          ["<C-h>"] = { "<C-o>b", desc = "1 word back" },
          ["<C-Right>"] = { "<C-o>w", desc = "1 word forward" },
          ["<C-l>"] = { "<C-o>w", desc = "1 word forward" },

          -- toggle comments
          ["<C-c>"] = { "<C-o>gcc", remap = true, desc = "Toggle comment line" },
        },
        v = {
          -- move with shift
          ["<S-Down>"] = { ":m '>+1<CR>gv=gv", desc = "move selection down" },
          ["<S-Up>"] = { ":m '<-2<CR>gv=gv", desc = "move selection up" },
          ["<S-Left>"] = { "<gv", desc = "move selection left" },
          ["<S-Right>"] = { ">gv", desc = "move selection right" },

          -- let cursor stay in the middle on PgUp/PgDn
          ["<PageDown>"] = { "<C-d>zz", desc = "page down" },
          ["<PageUp>"] = { "<C-u>zz", desc = "page up" },

          -- do stuff without overwriting the previous clipboard (e.g. for replacing marked text)
          ["p"] = { '"_dP', desc = "paste" },
          ["<leader>d"] = { '"_d', desc = "delete without yank" },

          -- q for word back is easier
          ["q"] = { "b", desc = "1 word back" },
          ["Q"] = { "B", desc = "1 word back" },

          -- CTRL motions
          ["<C-Up>"] = { "{", desc = "block up" },
          ["<C-k>"] = { "{", desc = "block up" },
          ["<C-Down>"] = { "}", desc = "block down" },
          ["<C-j>"] = { "}", desc = "block down" },
          ["<C-Left>"] = { "b", desc = "1 word back" },
          ["<C-h>"] = { "b", desc = "1 word back" },
          ["<C-Right>"] = { "w", desc = "1 word forward" },
          ["<C-l>"] = { "w", desc = "1 word forward" },

          -- access markers
          ["gm"] = { "'", desc = "go to markers" },

          -- toggle comments
          ["<C-c>"] = { "gc", remap = true, desc = "Toggle comments" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          gh = { vim.lsp.buf.hover, desc = "Hover symbol details" },
          gD = {
            vim.lsp.buf.declaration,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
          ["<leader>r"] = { vim.lsp.buf.rename, desc = "Symbol rename" },
          gd = { require("telescope.builtin").lsp_definitions, desc = "Go to symbol definition" },
          gI = { require("telescope.builtin").lsp_implementations, desc = "Go to symbol implementations" },
          gy = { require("telescope.builtin").lsp_type_definitions, desc = "Go to symbol type definitions" },
          gr = { require("telescope.builtin").lsp_references, desc = "Go to symbol references" },
          gc = { require("telescope.builtin").lsp_incoming_calls, desc = "Go to symbol incoming calls" },
          gC = { require("telescope.builtin").lsp_outgoing_calls, desc = "Go to symbol outgoing calls" },
          ["gG"] = {
            function()
              vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
                if query then
                  -- word under cursor if given query is empty
                  if query == "" then query = vim.fn.expand "<cword>" end
                  require("telescope.builtin").lsp_workspace_symbols {
                    query = query,
                    prompt_title = ("Find word (%s)"):format(query),
                  }
                end
              end)
            end,
            desc = "Search symbol in workspace",
          },
        },
      },
    },
  },
  -- replace stuff with telescope mappings
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      if opts.mappings.n["<Leader>lG"] then opts.mappings.n["<Leader>lG"][1] = function() end end
    end,
  },
}
