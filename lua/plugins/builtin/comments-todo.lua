return {
	-- makes TODO: and
	-- NOTE: pop more :)
	'folke/todo-comments.nvim',
	event = 'VimEnter',
	dependencies = {
		'nvim-lua/plenary.nvim',
		lazy = true
	},
	opts = { signs = false }
}
