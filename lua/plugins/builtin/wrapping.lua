return {
	-- Allows you to swap the wrapping style of some files.
	-- ';\' to swap, ';[' for soft wrap mode and ';]' for hard wrap mode.
	"andrewferrier/wrapping.nvim",
	lazy = true,
	opts = {
		softener = {
			markdown = true,
			text = true,
			txt = true
		},
		create_keymaps = false,
		create_commands = false,
	}
}
