-- [[
-- Since LSP Notify was causing issues while I was working on python files (it kept crashing? or something among those lines)
-- I decided to disable it.
-- Again, you are free to re-enable it if you desire! Just be warned that it *can* cause some trouble.
-- ]]

return {
	-- -- Makes your LSP notify you instead of yelling at you.
	-- 'mrded/nvim-lsp-notify',
	-- dependencies = {
	-- -- NOTE: We already have nvim-notify enabled by default!
	--
		-- 'rcarriga/nvim-notify',
	-- },
	-- config = function()
	-- 	require('lsp-notify').setup({
	-- 	notify = require('notify'),
	-- })
	-- end
}
