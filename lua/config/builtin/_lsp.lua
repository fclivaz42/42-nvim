-- [[ Configure LSP ]]--
--	This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })

	-- WARN: this little bit here is *only* here to support nvim-navic if you decide to enable it.
	-- It might very well disappear one day!
	local status, navic = pcall(require, "nvim-navic")
	if status then
		if client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
		end
		vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
	end
end

-- Load the user-specified LSP servers.
local servers = require("config.lsp_servers")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.tpp",
	callback = function()
		vim.bo.filetype = "cpp"
	end
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.tbl_deep_extend("force",
	vim.lsp.protocol.make_client_capabilities(),
	require('cmp_nvim_lsp').default_capabilities()
)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

-- Shut up we are loading the servers. Dont worry.
mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers)
}

for server_name, server in pairs(servers) do
	vim.lsp.config(server_name, {
		capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}),
		on_attach = on_attach,
		settings = (server or {}).settings,
		filetypes = (server or {}).filetypes,
		cmd = (server or {}).cmd
	})
end

-- Turn on diagnostic highlighting.
vim.diagnostic.config {
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = {
		severity = {
			min = "WARN",
			max = "ERROR"
		}
	},
	virtual_text = {
		source = 'if_many',
		spacing = 2,
		prefix = function(diagnostic)
			if vim.g.have_nerd_font == false then
				return '▸'
			end
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = '󰅚 ',
				[vim.diagnostic.severity.WARN] = '󰀪 ',
				[vim.diagnostic.severity.INFO] = '󰋽 ',
				[vim.diagnostic.severity.HINT] = '󰌶 ',
			}
			return diagnostic_message[diagnostic.severity]
		end
	},
}
