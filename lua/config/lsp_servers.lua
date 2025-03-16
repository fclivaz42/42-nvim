--[[ Expose which LSP servers we want to install and use. ]]
--
--	Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--	Add any additional override configuration in the following tables. They will be passed to
--	the `settings` field of the server config. You must look up that documentation yourself.
--
--	If you want to override the default filetypes that your language server will attach to you can
--	define the property 'filetypes' to the map in question.
--
--	NOTE: User-specified LSP servers may require additional packages to work (eg. go, npm, node).
--	Make sure they are installed, else Mason will throw an error.

return {
	clangd = {
		filetypes = {
			'c', 'h', 'm',
			'mm', 'cc',
			'cpp', 'cxx','c++','hpp', 'hxx', 'h++', 'tpp', 'ipp'
		},
		cmd = {
				'clangd',
				'--header-insertion=never',
				'-j=4',
				'--background-index',
				'--background-index-priority=low'
		}
	},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},

	-- NOTE: Add your own down here!
	-- A few examples:

	-- gopls = {},

	-- Python LSP with settings:

	-- pylsp = {
	-- 	pylsp = {
	-- 		plugins = {
	-- 			pycodestyle = {
	-- 				enabled = false
	-- 			}
	-- 		}
	-- 	}
	-- },

	--	-- WARN: rust-analyzer will *only* work in a directory created by 'cargo init'.
	--	--
	-- rust_analyzer = {},
	-- codelldb = {},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },
	-- ts_ls = {},
}
