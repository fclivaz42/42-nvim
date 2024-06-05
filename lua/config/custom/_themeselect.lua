-- [[ Choose your theme from one of those.
-- You can of course install your own and add them here later on! ]]--

-- Those are a few themes that are installed. Try them at will!
--vim.cmd.colorscheme 'astrotheme'
--vim.cmd.colorscheme 'neodarker'
--vim.cmd.colorscheme 'neodarker'
--vim.cmd.colorscheme 'tokyonight-night'
--vim.cmd.colorscheme 'tokyonight-day'
--vim.cmd.colorscheme 'tokyonight-storm'
--vim.cmd.colorscheme 'catppuccin-mocha'
vim.cmd.colorscheme 'onedark'

-- Switch themes easily
vim.keymap.set('n', '<leader>T', ':Telescope colorscheme<CR>', { desc = '[T]hemes' })
