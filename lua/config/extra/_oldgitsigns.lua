-- -- [[ Old gitsigns. ]] --
--
-- those here were commented out for more "in-line" signs.
-- Loading this file will re-enable them.

require('gitsigns').setup({
	signs = {
	add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	}
})
