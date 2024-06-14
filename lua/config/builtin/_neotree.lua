--[[ NeoTree configuration ]]--

-- opens NeoTree on startup
local function open_neotree()
	require('neo-tree.command').execute({
		action = "focus",
		source = "filesystem",
		position = "left",
		reveal_file = vim.fn.getcwd(),
		reveal_force_cwd = true,
	})
end

-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_neotree })

require("neo-tree").setup({
	source_selector = {
		winbar = true,
		satusline = true
	},
	close_if_last_window = false,
	sources = {
		'filesystem',
		'buffers',
		'git_status',
		'document_symbols'
	},
	window = {
		position = "left",
		width = 40,
		mapping_options = {
		noremap = true,
		nowait = true,
		},
		mappings = {
			["<space>"] = {
				"toggle_node",
				nowait = false
			},
			["<2-LeftMouse>"] = "open_with_window_picker",
			["<cr>"] = "open_with_window_picker",
			["<esc>"] = "cancel", -- close preview or floating neo-tree window
			["P"] = {
				"toggle_preview",
				config = {
					use_float = true,
					use_image_nvim = true
				}
			},
			-- Read `# Preview Mode` for more information
			["l"] = "focus_preview",
			["<C-V>"] = "vsplit_with_window_picker",
			["<C-X>"] = "split_with_window_picker",
			-- ["S"] = "split_with_window_picker",
			-- ["s"] = "vsplit_with_window_picker",
			["t"] = "open_tabnew",
			-- ["<cr>"] = "open_drop",
			-- ["t"] = "open_tab_drop",
			["w"] = "open_with_window_picker",
			--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
			["C"] = "close_node",
			-- ['C'] = 'close_all_subnodes',
			["z"] = "close_all_nodes",
			--["Z"] = "expand_all_nodes",
			["a"] = {
			  "add",
			  -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
			  -- some commands may take optional config options, see `:h neo-tree-mappings` for details
			  config = {
			    show_path = "none" -- "none", "relative", "absolute"
			  }
			},
			["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
			-- ["c"] = {
			--  "copy",
			--  config = {
			--    show_path = "none" -- "none", "relative", "absolute"
			--  }
			--}
			["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
			["i"] = "show_file_details",
		}
	},
})

vim.api.nvim_set_keymap("n", "<C-h>", ":Neotree toggle position=left<cr>", {
	silent = true,
	noremap = true
})
