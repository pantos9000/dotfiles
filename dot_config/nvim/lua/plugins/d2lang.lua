-- TODO does not seem to work? fix warning?
return {
    "terrastruct/d2-vim",
    config = function()
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.d2 = {
            install_info = {
                url = 'https://github.com/pleshevskiy/tree-sitter-d2',
                revision = 'main',
                files = { 'src/parser.c', 'src/scanner.cc' },
            },
            filetype = 'd2',
        }
    end,
}
