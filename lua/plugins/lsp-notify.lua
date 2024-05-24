return {
	-- Makes your LSP notify you instead of yelling at you.
	'mrded/nvim-lsp-notify',
	requires = { 'rcarriga/nvim-notify' },
	config = function()
		require('lsp-notify').setup({
		notify = require('notify'),
	})
	end
}
