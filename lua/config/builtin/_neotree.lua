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
	nesting_rules = {},
	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_hidden = true, -- only works on Windows for hidden files/directories
			hide_by_name = {
				--"node_modules"
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta",
				--"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				".gitignore",
			},
			always_show_by_pattern = { -- uses glob style patterns
				--".env*",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				".DS_Store",
				"thumbs.db"
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		follow_current_file = {
			enabled = false, -- This will find and focus the file in the active buffer every time
							-- the current file is changed while the tree is open.
			leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
													-- in whatever position is specified in window.position
								  -- "open_current",  -- netrw disabled, opening a directory opens within the
													-- window like netrw would, regardless of window.position
								  -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
		use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
											-- instead of relying on nvim autocmd events.
		window = {
			mappings = {
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
				-- ["D"] = "fuzzy_sorter_directory",
				["f"] = "filter_on_submit",
				["<c-J>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
				["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["og"] = { "order_by_git_status", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
				-- ['<key>'] = function(state) ... end,
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "move_cursor_down",
				["<C-n>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-p>"] = "move_cursor_up",
				-- ['<key>'] = function(state, scroll_padding) ... end,
			},
		},

		commands = {} -- Add a custom command or override a global one using the same function name
	},
	buffers = {
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
			--	            -- the current file is changed while the tree is open.
			leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			}
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"]  = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
				["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			}
		}
	}
})

vim.api.nvim_set_keymap("n", "<C-h>", ":Neotree toggle position=left<cr>", {
	silent = true,
	noremap = true
})

vim.api.nvim_set_keymap("n", "<C-d>", ":Neotree document_symbols position=right<cr>", {
	silent = true,
	noremap = true
})