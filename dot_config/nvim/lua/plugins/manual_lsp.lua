return {
  "AstroNvim/astrolsp",
  -- we need to use the function notation to get access to the `lspconfig` module
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    -- insert servers into our list of servers
    opts.servers = opts.servers or {}
    table.insert(opts.servers, "bashls")

    -- extend our configuration table to have our new server
    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
      -- this must be a function to get access to the `lspconfig` module
      bashls = {
        -- the command for starting the server
        cmd = {
          "/snap/bash-language-server/current/bin/node",
          "/snap/bash-language-server/current/lib/node_modules/bash-language-server/out/cli.js",
          "start",
        },
        -- the filetypes to attach the server to
        filetypes = { "sh", "bash" },
        -- root directory detection for detecting the project root
        root_dir = require("lspconfig.util").root_pattern ".git",
      },
    })
  end,
}
