return {
  'nvim-treesitter/nvim-treesitter',
  main = 'nvim-treesitter.configs',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', lazy = true },
  },
  build = ':TSUpdate',
  init = function(plugin)
    require('lazy.core.loader').add_to_rtp(plugin)
    require('nvim-treesitter.query_predicates')
  end,
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
  },
}
