return {
	-- Integrated lazygit, straight into into neovim
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
			lazy = true
		},
		'nvim-telescope/telescope.nvim',
	},
	config = function()
		require("telescope").load_extension("lazygit")
	end,
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	--
	-- use <space-l-g> to bring it out, and 'q' to quit it.
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
	}
}
