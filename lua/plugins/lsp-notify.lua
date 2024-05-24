return {
	'mrded/nvim-lsp-notify',
	requires = { 'rcarriga/nvim-notify' },
	config = function()
		require('lsp-notify').setup({
		notify = require('notify'),
	})
	end
}
