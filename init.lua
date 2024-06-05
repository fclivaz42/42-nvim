--[[ broller config :) ]] --

-- Set Vim settings. Necessary before lazy is run.
require "config.vim_settings"

-- Install lazy.nvim, the package manager.
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Validate that lazy is available.
if not pcall(require, "lazy") then
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- Load Lazy and make sure every plugin is installed.
require "lazy_load"

-- Load config/init.lua
require "config"

-- Launch! :)
if (vim.g.user42 == nil) then
	vim.g.user42 = vim.env.USER
end
vim.notify = require("notify")
vim.notify("Welcome back " .. vim.g.user42 .. "! :)\nUse 'space-T' to switch between themes.", "info", { title = " 42-Nvim" })

if (vim.g.user42 == "SET YOUR USER UP") then
vim.notify("If you see this you havent configured your stuff!\nDon't forget to take a peek to your ~/.config/nvim", "error", { title = " 42-Nvim" })
end
