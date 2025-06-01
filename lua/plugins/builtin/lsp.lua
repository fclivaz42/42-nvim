return {
	-- This is where your plugins related to LSP can be installed.
	-- The configuration is done below. Search for lspconfig to find it below.
	-- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{
			'mason-org/mason.nvim',
			config = true
		},
		'mason-org/mason-lspconfig.nvim',
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {}
		}
	}
}
