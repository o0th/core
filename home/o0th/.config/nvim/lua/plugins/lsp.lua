return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.on_attach(function(_, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
    end)

    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'vimls' },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
          require('lspconfig')['lua_ls'].setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim', 'feedkey' },
                },
              },
            },
          })
        end,
      },
      lua_ls = {},
    })
  end,
}
