return {
	'Mofiqul/dracula.nvim',
	priority = 1000,
	init = function()
		vim.cmd.colorscheme('dracula')
	end,
	config = {
		italic_comment = true,
		show_end_of_buffer = true,
	}
}
