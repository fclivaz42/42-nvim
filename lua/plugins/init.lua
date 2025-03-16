--[[ Lazy config file. ]] --

---@diagnostic disable: missing-fields
require('lazy').setup({
	-- First, some plugins that don't require any configuration
	'tpope/vim-obsession',
	'tpope/vim-fugitive',
	'tpope/vim-surround',
	'nvim-tree/nvim-web-devicons',
	{
		'brenoprata10/nvim-highlight-colors',
		config = true
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},


	-- Then load every 42 plugin...
	-- NOTE: If you are not from 42 or don't know what it is,
	-- you can delete this next line and the 42 folder!
	{	import = 'plugins.42'	},

	-- Then load every plugin that came bundled...
	{	import = 'plugins.builtin'	},

	-- Then load every plugin that was uncommented in extras...
	{	import = 'plugins.extras'	},

	-- Then load every custom plugin you added...
	{	import = 'plugins.custom'	},

	-- And then load every theme.
	{	import = 'plugins.themes'	}
})
