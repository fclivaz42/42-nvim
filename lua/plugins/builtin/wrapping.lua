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
	},
	keys = {
		{ ";[", require('wrapping').soft_wrap_mode, desc = 'Soft Wrap mode' },
		{ ";]", require('wrapping').hard_wrap_mode, desc = 'Hard Wrap mode' },
		{ ";\\", require('wrapping').toggle_wrap_mode, desc = 'Toggle Wrap mode' }
	}
}
