local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

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

    local cmp = require('cmp')
    local luasnip = require('luasnip')

    require('cmp').setup({
      mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
    })

    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls' },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
      },
      lua_ls = {},
    })

    local autocmd_group = vim.api.nvim_create_augroup('Custom auto-commands', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      pattern = { '*.lua' },
      desc = 'Auto-format YAML files after saving',
      callback = function()
        local fileName = vim.api.nvim_buf_get_name(0)
        -- stylua.format_file()
        vim.cmd(':silent !stylua ' .. fileName)
      end,
      group = autocmd_group,
    })
  end,
}