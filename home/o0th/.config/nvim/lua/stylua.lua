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
else
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
end
