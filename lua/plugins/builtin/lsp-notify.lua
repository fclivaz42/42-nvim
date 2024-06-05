return {
	-- Makes your LSP notify you instead of yelling at you.
	'mrded/nvim-lsp-notify',
	dependencies = {
		-- adds some nice notifications
		'rcarriga/nvim-notify',
		lazy = true
	},
	config = function()
		require('lsp-notify').setup({
		notify = require('notify'),
	})
	end
}
