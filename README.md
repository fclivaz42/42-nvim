# 42-Nvim
---
### _A "community-driven" Neovim configuration supercharged for 42 Students._

Heavily based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and [AstroNvim](https://github.com/AstroNvim/AstroNvim), this Neovim "distribution" (its just a configuration but shh) has been created with the aim of being a solid, modular, intuitive and enjoyable way to use vim/neovim. Including a built-in norminette and stdheader, it is an amazing code editor for 42 students!

## Installing 42-Nvim
---
42-Nvim was created with expandability in mind. In order to install, forking this repository is recommended. This way, you can edit your config, change your setup, etc and still be able to sync it to Github! Also, if there are any changes from upstream (here), you will be able to update without breaking your configuration. If you also end up adding plugins that could benefit the community, simply make a pull/merge request and it will be reviewed. If a general use-case is warranted, your config will be merged and moved into the built-in section. More on that later.

Once you forked this repo, simply execute the following:
```shell
mv ~/.config/nvim ~/.config/nvim.bak
git clone git@github.com:<your_name_here>/42-nvim.git ~/.config/nvim
vim ~/.config/nvim/lua/config/42/init.lua
```
Make sure to change `<your_name_here>` to your github login!

This will also launch `vim` one last time to edit your `user42` and `mail42` as well as allow you to turn on the built-in `norminette`, if you want that.

After that, you can simply start `nvim`! Lazy will then download and install a bunch of packages, so make sure you let it install everything before closing.

***It is also recommended if not mandatory to install a Nerd Font! [Meslo](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo) is a good one.***
### Recommended, but optional post-install steps:
---
`:Mason` will bring out the LSP installer, with which you can install software such as `clang-format` and most importantly `clangd` if your system does not have it preinstalled.
**However if `clangd` is already installed, you should edit `~/.config/nvim/lua/config/custom/_clangd.lua` and uncomment line 4.**

It is also recommended to run the following:
```shell
chmod a+x ~/.config/nvim/.clangdflags.sh
bash ~/.config/nvim/.clangdflags.sh
```
This will tell `clangd` to use the `-Wall -Werror -Wextra` flags when running.

You should also take a tour in the config folder! just to see whats going on, figure out a couple keybinds maybe. I left notes and comnents everywhere, explaining which plugin does what (and left a bunch of comments that were imported from [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Again, huge kudos to them).
### Custom configuration? How do I install my own plugins? Themes?
---
As said, 42-Nvim was made to be extended. Therefore, a `custom` subfolder exists in both the `config` and the `plugins` folders, with examples. Both `plugins/custom` and `config/custom` won't ever be changed or modified upstream - this will be where you import and configure your plugins. There are examples that are there, so feel free to explore and import whatever you'd like!
As a reminder, if you feel like a plugin/configuration could benefit more people, you can create a pull/merge request. I will review it, and if it does improve the "distro" in any way, I'll merge it and move it to the built-ins folder.

For theming, a `_themeselect.lua` file is waiting for you in the `config/custom` subfolder where you can choose which theme to use. If you want to install your own, you can always drop a `.lua` file in `plugins/themes`, as if it were an extra plugin. Once in Neovim, press Space-T to open up a theme selector!
### Keybinds?? Where?? Help????
---
Press space, then 's' and 'h' to bring out a help menu.

Control-W will be the leader key to move around.

Space will be the leader key for many other binds.

'g' will be the leader for code editing (eg. comment and allat)

While in normal mode, pressing leader keys and doing nothing afterwards will show you which possible keybinds can be achieved. This is done thanks to [which-key](https://github.com/folke/which-key.nvim).

Again, feel free to mess around and explore the config files. You may (will) learn a thing or two!
### Credits, contact and whatever
---
As I said, this would not have been possible without these two goats:
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [AstroNvim](https://github.com/AstroNvim/AstroNvim)

**In addition, I'd like to link back to *every* built-in plugin that made this "distribution" possible.** This should make it easier to navigate and see which plugins are installed, as well as making their documentation a little bit faster to access. And of course to credit them for their amazing work :)

<details><summary>Plugins used:</summary>

- [42 Header](https://github.com/42Paris/42header)
- [Norminette42](https://github.com/hardyrafael17/norminette42.nvim)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [vim-obsession](https://github.com/tpope/vim-obsession)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [vim-rhubarb](https://github.com/tpope/vim-obsession)
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [nvim-lsp-notify](https://github.com/mrded/nvim-lsp-notify)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [lualine.nvim](https://github.com/folke/nvim-lualine/lualine.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [which-key.nvim](https://github.com/folke/which-key.nvim)

</details>

<details><summary>Built-in themes:</summary>

- [AstroTheme](https://github.com/AstroNvim/astrotheme)
- [OneDark.nvim](https://github.com/navarasu/onedark.nvim)
- [NeoDark.nvim](https://github.com/VDuchauffour/neodark.nvim) -- RIP in piece little angle, you will be missed :(
- [Tokyo Night](https://github.com/folke/tokyonight.nvim)
- [Catppuccin](https://github.com/catppuccin/nvim)

</details>

You can contact me on Discord by sending a friend request to `broller` if you need help with anything, although I'd prefer if you could open an issue if applicable!

Enjoy 42-Nvim! :)
