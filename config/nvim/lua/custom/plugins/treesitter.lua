-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'blade', 'php_only' },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true, disable = { 'ruby' } },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['if'] = '@function.inner',
          ['af'] = '@function.outer',
          ['ia'] = '@parameter.inner',
          ['aa'] = '@parameter.outer',
        },
      },
    },
  },
  config = function(_, opts)
    vim.filetype.add {
      pattern = {
        ['.*%.blade%.php'] = 'blade',
      },
    }

    require('nvim-treesitter.configs').setup(opts)
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = 'https://github.com/EmranMR/tree-sitter-blade',
        files = { 'src/parser.c' },
        branch = 'main',
      },
      filetype = 'blade',
    }
  end,
}
