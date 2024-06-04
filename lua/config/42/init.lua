-- [[ 42 Settings! ]]

-- NOTE: If you are from 42, **you might want to edit these** :)
--
-- 42 Global Variables.
vim.g.user42 = 'SET YOUR USER UP'
vim.g.mail42 = 'SET YOUR EMAIL UP'

require("norminette").setup({
	runOnSave = true,
	maxErrorsToShow = 15,
	-- NOTE: Edit this to true if you want integrated Normiette!
	-- Make sure to have it installed first (eg. with pip)
	active = false,
})
