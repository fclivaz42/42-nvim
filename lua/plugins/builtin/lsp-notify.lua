return {
	-- Makes your LSP notify you instead of yelling at you.
	-- 'mrded/nvim-lsp-notify',
	-- dependencies = {
		-- adds some nice notifications
		'rcarriga/nvim-notify',
		opts = {
			fps = 60,
			render = 'compact',
			timeout = 100,
		},
		lazy = true
	-- },
	-- config = function()
	-- 	require('lsp-notify').setup({
	-- 	notify = require('notify'),
	-- })
	-- end
}
