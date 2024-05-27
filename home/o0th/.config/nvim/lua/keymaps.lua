-- Quicksave
vim.api.nvim_set_keymap('n', '<leader>w', '<cmd>w<cr>', {})

-- Navigate buffers
vim.api.nvim_set_keymap('n', '<S-h>', '<cmd>bprev<cr>', {})
vim.api.nvim_set_keymap('n', '<S-l>', '<cmd>bnext<cr>', {})
vim.api.nvim_set_keymap('n', '<S-c>', '<cmd>bd<cr>', {})

-- Trouble
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>TroubleToggle<cr>', {})
