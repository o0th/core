return {
  'editorconfig/editorconfig-vim',
  'tpope/vim-sleuth',
  config = function()
    require('vim-sleuth').setup()
    require('editorconfig-vim').setup()
  end,
}
