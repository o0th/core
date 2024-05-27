-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set scrollff
vim.opt.scrolloff = 12

-- Do not use swapfile
vim.opt.swapfile = false

-- Show line numbers
vim.opt.number = true

-- Highlight current line
vim.opt.cursorline = true

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Do not show mode
vim.opt.showmode = false

--#region
vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.termguicolors = true

-- Set indentation options
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 0
vim.o.tabstop = 2
vim.o.copyindent = true

-- Enable filetype plugin and indent
vim.cmd('filetype plugin indent on')
