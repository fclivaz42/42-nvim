--[[ Lazy config file. ]] --

require('lazy').setup({
	-- First, some plugins that don't require any configuration
	'tpope/vim-obsession',
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	'elkowar/yuck.vim', -- necessary for eww config, you can delete this if you aren't me
	'nvim-tree/nvim-web-devicons',
	'nvim-tree/nvim-tree.lua',
	'fclivaz42/42header-ls',

	-- Then load every plugin that requires configuration...
	{	import = 'plugins'	},

	-- And then load every theme.
	{	import = 'plugins.themes'	}
})
