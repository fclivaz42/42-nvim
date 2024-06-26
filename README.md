# 42-Nvim
---
### _A "community-driven" Neovim configuration supercharged for 42 Students._

Heavily based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and [AstroNvim](https://github.com/AstroNvim/AstroNvim), this Neovim "distribution" (its just a configuration but shh) has been created with the aim of being a solid, modular, intuitive and enjoyable way to use vim/neovim. Including a built-in norminette and stdheader, it is an amazing code editor for 42 students!

## Installing 42-Nvim
---
42-Nvim was created with expandability in mind. In order to install, forking this repository is recommended. This way, you can edit your config, change your setup, etc and still be able to sync it to Github! Also, if there are any changes from upstream (here), you will be able to update without breaking your configuration. If you also end up adding plugins that could benefit the community, simply make a pull/merge request and it will be reviewed. If a general use-case is warranted, your config will be merged and moved into the built-in section. More on that later.

Once you forked this repo, simply execute the following (make sure to change `<your_name_here>` to your github login!):
```shell
mv ~/.config/nvim ~/.config/nvim.bak
git clone git@github.com:<your_name_here>/42-nvim.git ~/.config/nvim
vim ~/.config/nvim/lua/config/42/init.lua
```

This will also launch `vim` one last time to edit your `user42` and `mail42` as well as allow you to turn on the built-in `norminette`, if you want that.

Once that is done, you can simply start `nvim`! Lazy will then download and install a bunch of packages, so make sure you let it install everything before closing.

**You should also install a few dependencies for extra functionality:**
- `gcc`, `git`, `make`, `unzip` which _should_ be pre-installed, but it's better to double-check.
- [lazygit](https://github.com/jesseduffield/lazygit)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- ***Install a Nerd Font for extra glyphs! [Meslo](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo) is a good one.***
If you cannot install those dependencies on 42 iMacs (eg. with [brew](https://github.com/kube/42homebrew)), you can always download the binaries and put them in your `$PATH`.

### Recommended, but optional post-install steps:
---
`:Mason` will bring out the LSP installer, with which you can install software such as `clang-format`. `clangd` will be installed and configured automatically.

It is recommended to run the following:
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

Here's a little peek at the folder structure:
```
~/.config/nvim
┌───────────┘
├─ init.lua -- init file.
├─ .clangdflags.sh -- run this :)
└─ lua
    ├─ lazy_load.lua -- This calls the plugin manager. Delete the 42 line if you aren't from 42 (somehow).
    ├─ config
    │	├─ vim_settings.lua --  Here, you can configure your general vim settings.
    │	├─ 42 -- The init.lua file in this folder stores the user42, mail42 and norminette settings. Change them to suit your preferences.
    │	├─ builtin -- The config files for built-in plugins. Don't touch anything here as they may change! Or deal with the git conflicts :)
    │	├─ custom <<-- Here's the folder where you will load your configuration! The init.lua file and _themeselect.lua will have examples.
    │	└─ init.lua -- Don't touch this, it's used to load all the config.
    └─ plugins
	├─ 42 -- The init.lua file in this folder loads the 42Stdheader (Lausanne, by default. Change this if you are not from Lausanne!)
	├─ builtin -- This folder contains all the built-in plugins that make 42-Nvim what it is. Don't touch as it might get modified.
	├─ custom <<-- This is where you want to add your lua files to add custom plugins. An example file lives there.
	└─ themes -- This folder contains all the current themes. You may add your own or delete those you don't use.
```

### Keybinds?? Where?? Help????
---
Press space, then `s` and `h` to bring out a help menu.

When opening Neovim without any arguments, press `u` to launch Lazy and update all of your plugins. `f` will launch Telescope to search a file in the current directory. `p` will push your current Neovim config to your git clone and `P` will pull it instead. Relaunch after pulling your config!

<details><summary>Neo-tree shortcuts:</summary>
This section is the largest out of the bunch.

Keep in mind that most shortcuts only work when the cursor/focus is on Neo-Tree!

| Keybind | Shortcut |
| :------ | :------- |
| `<CTRL-H>` | Toggle the Neo-Tree |
| `<CTRL-D>` | Toggle the Document Symbols pane |
| `<Space>` | Toggle folder (open/close) |
| `<Enter>` | Open file with widow picker |
| `<2-MouseL>` | Open file with widow picker |
| `<CTRL-V>` | Open selected file, splitting the selected buffer vertically |
| `<CTRL-X>` | Open selected file, splitting the selected buffer horizontally |
| `<CTRL-K>` | Add selected file/folder to Dashboard recents (can have up to 10) |
| `<Backspace>` | Navigate up a level (open parent directory) |
| `.` | Set folder as current working directory and focus to it |
| `w` | Open file when there is no buffer to split |
| `a` | Create file (supports BASH-like extension, eg `file.{c,h}pp` will create `file.cpp` and `file.hpp`) |
| `A` | Create folder |
| `c` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `C` | Copy using a prompt |
| `m` | Move using a prompt |
| `r` | Rename file/folder |
| `d` | Delete file/folder |
| `R` | Refresh Neo-Tree |
| `H` | Toggle hidden files |
| `i` | Show file info |
| `P` | Preview file contents |
| `e` | Focus on filesystem |
| `b` | Focus on open buffers |
| `g` | Focus on git status |
| `>` | Switch to next source |
| `<` | Switch to prev source |

</details>

<details><summary>Movement shortcuts:</summary>
`Control-W` will be the leader key to move around.
Follow with the arrow keys or the vim `HJKL` to move buffers.
You can split the window with `s`.
</details>

<details><summary>General shortcuts:</summary>
`Space` will be the leader key for many other binds.
Pressing `Space` again will bring out Telescope.
`/` will bring out a fuzzy finder that searches in the current open buffer.
</details>

<details><summary>Coding shortcuts:</summary>
`g` will be the leader for code editing (eg. comment and allat)
`gcc` will toggle comment the line the cursor is on.
With a selected block, in Visual mode, `gc` will toggle comment on the selection.
Hovering a function, `gd` will go to its definition, while `gD` will go to its declaration and `gr` will show a menu previewing every reference to it.
There is a lot more to this so press `g` once and see what other keybinds you can use :)
</details>

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
- [vim-surround](https://github.com/tpope/vim-surround)
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [neodev.nvim](https://github.com/folke/neodev.nvim)
- [nvim-window-picker](https://github.com/s1n7ax/nvim-window-picker)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [image.nvim](https://github.com/3rd/image.nvim)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
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
- [wrapping.nvim](https://github.com/andrewferrier/wrapping.nvim)

</details>

<details><summary>Built-in themes:</summary>

- [AstroTheme](https://github.com/AstroNvim/astrotheme)
- [OneDark.nvim](https://github.com/navarasu/onedark.nvim)
- [NeoDark.nvim](https://github.com/VDuchauffour/neodark.nvim) -- RIP in piece little angle, you will be missed :(
- [Tokyo Night](https://github.com/folke/tokyonight.nvim)
- [Catppuccin](https://github.com/catppuccin/nvim)

</details>

(if i missed one im sorry)

You can contact me on Discord by sending a friend request to `broller` if you need help with anything, although I'd prefer if you could open an issue if applicable!

Enjoy 42-Nvim! :)
