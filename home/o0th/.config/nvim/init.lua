--
-- Lazyvim
--

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

--
-- Requires
--

require('options')
require('keymaps')
require('lazy').setup('plugins')

---
--- Spinner
---

local spinner = {
  '[    ]',
  '[=   ]',
  '[==  ]',
  '[=== ]',
  '[ ===]',
  '[  ==]',
  '[   =]',
  '[    ]',
}

--
-- Linters
--

local list = io.popen('cargo install --list')
if list == nil then
  return false
end

local result = list:read('*a')
list.close()

if string.find(result, 'stylua') == nil then
  local spinner_index = 1
  local on_stdout = function(_, data, _)
    for _, line in ipairs(data) do
      if line ~= '' then
        vim.notify(spinner[spinner_index] .. ' ' .. line)
        spinner_index = (spinner_index % #spinner) + 1
      end
    end
  end

  local on_stderr = function(_, data, _)
    for _, line in ipairs(data) do
      if line ~= '' then
        vim.notify(spinner[spinner_index] .. ' ' .. line)
        spinner_index = (spinner_index % #spinner) + 1
      end
    end
  end

  vim.fn.jobstart('cargo install stylua', {
    stdout_buffered = true,
    on_stdout = on_stdout,
    on_stderr = on_stderr,
  })
end
