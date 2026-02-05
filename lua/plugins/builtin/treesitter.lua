return {
	-- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	branch = "main",
	lazy = false,
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
		branch = "main",
	},
	build = ':TSUpdate',
}
