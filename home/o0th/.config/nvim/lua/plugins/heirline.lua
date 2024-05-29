return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'f-person/git-blame.nvim',
  },
  config = function()
    local git_blame = require('gitblame')
    vim.g.gitblame_display_virtual_text = 0
    vim.g.gitblame_message_template = '<summary> (<author> <date>)'
    vim.g.gitblame_date_format = '%r'

    require('lualine').setup({
      options = {
        -- theme = bubbles_theme,
        icons_enabled = true,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '', right = '' }, right_padding = 2 },
        },
        lualine_b = { 'branch', 'filename' },
        lualine_c = {
          { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
        },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '', left = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
