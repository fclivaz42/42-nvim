return {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	-- This theme is default with Kickstart.nvim, the base I used to create this configuration.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
		-- You can configure highlights by doing something like:
		vim.cmd.hi 'Comment gui=none'
    end,
}
