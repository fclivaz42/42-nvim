--[[ Config loader. ]]--

-- Load Telescope Settings.
require "config.builtin.telescope"

-- Load Treesitter Settings.
require "config.builtin.treesitter"

-- Load LSP Settings.
require "config.builtin.lsp"

-- Load Autocompletion Settings.
require "config.builtin.cmp"

-- Load File Tree Settings.
require "config.builtin.nvimtree"

-- Set theme.
require "config.builtin.themeselect"

-- Load 42 settings.
require "42"

-- Load custom configs
require "custom"
