-- [[ Configure Treesitter ]]--
-- See `:help nvim-treesitter`
--

local filetypes = require("config.ts_languages")

require('nvim-treesitter').setup
{
	-- Automatically install the parsers defined in ts_languages.lua
	require('nvim-treesitter').install(filetypes),

	-- Define where the comipled parsers should go
	install_dir = vim.fn.stdpath('data') .. '/site',

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<c-space>',
			node_incremental = '<c-space>',
			scope_incremental = '<c-s>',
			node_decremental = '<M-space>',
		},
	},

	-- Since treesitter highlighting, folding is provided by nvim now, that's what this autocmd does.
	-- The indenting is considered experimental but we want to enable it nonetheless.
	vim.api.nvim_create_autocmd('FileType', {
		pattern = filetypes,
		callback = function()
			-- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			-- vim.wo[0][0].foldmethod = 'expr'
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.treesitter.start()
		end,
	}),

	-- Updated for the new Textobjects handling.
	require("nvim-treesitter-textobjects").setup {
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>A'] = '@parameter.inner',
				}
			}
		}
	}
}

-- TPP files are technically headers? or cpp files?
vim.filetype.add({
	extension = {
		tpp = "hpp",
		sh = 'bash'
	}
})
