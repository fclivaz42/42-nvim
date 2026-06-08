-- [[ Configure nvim-cmp ]]--
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local function set_cmp_border()
	local hl = vim.api.nvim_get_hl(0, { name = 'FloatBorder', link = false })
	if not hl.fg then
		hl = vim.api.nvim_get_hl(0, { name = 'Comment', link = false })
	end
	vim.api.nvim_set_hl(0, 'CmpBorder', { fg = hl.fg, bg = 'NONE' })
end

-- Apply the border highlight on startup and whenever the colorscheme changes
set_cmp_border()
vim.api.nvim_create_autocmd('ColorScheme', {
	callback = set_cmp_border,
})

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.insert,
			select = false,
		},
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'buffer' },
		{ name = 'luasnip' },
	},
	window = {
		completion = cmp.config.window.bordered({
			border = 'rounded',
			winhighlight = 'Normal:Normal,FloatBorder:CmpBorder,CursorLine:Visual,Search:None',
		}),
		documentation = cmp.config.window.bordered({
			border = 'rounded',
			winhighlight = 'Normal:Normal,FloatBorder:CmpBorder,CursorLine:Visual,Search:None',
		}),
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text',
			maxwidth = 50,
			ellipsis_char = '...',
			show_labelDetails = true,

			-- The 'menu' section allows you to customize the label of the source
			menu = ({
				buffer = "[Buffer] ",
				nvim_lsp = "[LSP] ",
				luasnip = "[Snip] ",
				path = "[Path] ",
			})
		}),
	},
}
