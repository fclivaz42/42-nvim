# 42-Nvim
### _A "community-driven" Neovim configuration supercharged for 42 Students._

Heavily based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and [AstroNvim](https://github.com/AstroNvim/AstroNvim), this Neovim "distribution" (its just a configuration but shh) has been created with the aim of being a solid, modular, intuitive and enjoyable way to use vim/neovim. Including a built-in norminette and stdheader, it is an amazing code editor for 42 students!

---
## Installing 42-Nvim
42-Nvim was created with expandability in mind. **In order to install, forking this repository is recommended.** This way, you can edit your config, change your setup, etc and still be able to sync it to Github! Also, if there are any changes from upstream (here), you will be able to update without breaking your configuration. If you also end up adding plugins that could benefit the community, simply make a pull/merge request and it will be reviewed. If a general use-case is warranted, your config will be merged and moved into the built-in section. More on that later.

Once you forked this repo, simply execute the following and follow the steps!:
```shell
curl -fsSL https://raw.githubusercontent.com/fclivaz42/42-nvim/refs/heads/main/install.sh -o installer.sh && bash installer.sh install
```

This will prompt you to clone your fork and adjust a few settings (eg. `user42`, `mail42`, allow you to turn on the built-in norminette and install the recommended `clangd` flags) as well as check if the recommended dependencies are installed.

Once that is done, you can simply start `nvim`! Lazy will then download and install a bunch of packages, so make sure you let it install everything before closing.

**Make sure those dependencies are installed!** The script will warn you if anything is missing, just in case.
- `gcc`, `git`, `make`, `unzip` which _should_ be pre-installed, but it's better to double-check.
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [lazygit](https://github.com/jesseduffield/lazygit) (Optional, but recommended)
- [LazyDocker](https://github.com/jesseduffield/lazydocker) (Optional)
- ***Install a Nerd Font for extra glyphs! [Meslo](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo) is a good one and the script will prompt you to download it.***

If you cannot install those dependencies on 42 iMacs (eg. with [brew](https://github.com/kube/42homebrew)), you can always download the binaries and put them in your `$PATH`.

---
## Recommended, but optional post-install steps:
`:Mason` will bring out the LSP installer, with which you can install software such as `clang-format`. `clangd` will be installed and configured automatically.

If you have decided to avoid setting the `clangd` flags and would like to do it afterwards, you can always run:
```shell
bash ~/.config/nvim/install.sh cflags
```
This will tell `clangd` to use the `-Wall -Werror -Wextra` flags when running.

You should also take a tour in the config folder! just to see whats going on, figure out a couple keybinds maybe. I left notes and comnents everywhere, explaining which plugin does what (and left a bunch of comments that were imported from [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Again, huge kudos to them).

---
## Updating 42-Nvim:
There are two ways to update 42-Nvim. The first one (and the easiest one) is to simply enter `nvim` and press `<Shift>-U` at the dashboard, which will fetch upstream and merge it into your branch.
The second way is as simple as installing it. You can either run the script locally:
```shell
bash ~/.config/nvim/install.sh update
```
Or update using the latest script in my repo:
```shell
curl -fsSL https://raw.githubusercontent.com/fclivaz42/42-nvim/refs/heads/main/install.sh -o installer.sh && bash installer.sh update
```
This should add `upstream`, fetch and merge automatically. Make sure to double-check everything happened properly. The current version should be shown at the bottom of your Dashboard.

---
## Custom configuration? How do I install my own plugins? Themes?
As said, 42-Nvim was made to be extended. Therefore, a `custom` subfolder exists in both the `config` and the `plugins` folders, with examples. Both folders `plugins/custom` and `config/custom` *will not* be changed or modified upstream - this will be where you import and configure your plugins. Custom will also override any previous configuration, so if you wish to change the behavior of a plugin, you can override 42-Nvim's defaults there. There are examples that are there, so feel free to explore and import whatever you'd like!
There is also an `extras` subfolder which houses **disabled** previous configurations or plugins (and plugins I have tried during testing phase but did not keep.) You are free to modify/enable any configuration you like in that as well (if you wish to roll back some changes or enable "testing" plugins), but beware that 42-Nvim might behave oddly if so.
Any changes in `extras` and `custom` *will override* the default 42-Nvim configuration, so this is where you want to tinker if you wish to modify 42-Nvim's behavior.
As a reminder, if you feel like a plugin/configuration could benefit more people, you can create a pull/merge request. I will review it, and if it does improve the "distro" in any way, I'll merge it and move it to the built-ins folder. If I do find some use but feel like it "breaks the spirit" or whatnot, I can always move it to `extras` which means it's just an enable away from being used.

For theming, a `_themeselect.lua` file is waiting for you in the `config/custom` subfolder where you can choose which theme to use. If you want to install your own, you can always drop a `.lua` file in `plugins/themes`, as if it were an extra plugin. Once in Neovim, press `<Space>-T` to open up a theme selector!

Here's a little peek at the folder structure:
```
~/.config/nvim
┌───────────┘
├─ init.lua -- init file.
├─ install.sh -- the installer/updater/clangd script for 42-Nvim. You get a local copy too!
└─ lua
    ├─ config
    │	├─ vim_settings.lua --  Here, you can configure your general vim settings.
    │	├─ 42 -- The init.lua file in this folder stores the user42, mail42 and norminette settings. Change them to suit your preferences.
    │	├─ builtin -- The config files for built-in plugins. Don't touch anything here as they may change! Or deal with the git conflicts :)
    │	├─ custom <<-- Here's the folder where you will load your configuration! The init.lua file and _themeselect.lua will have examples.
    │	├─ extras <<-- Here's a folder where old configurations are stored, in case you wish to personally roll back.
    │	├─ vim_settings.lua <<-- This file hosts most of the basic vim behavior config. You can also dis or enable the 42-Nvim updater.
    │	├─ lsp_servers.lua <<-- This file describes which LSP's you want to install/configure with or without settings.
    │	├─ ts_languages.lua <<-- This file tells Tree-Sitter which languages should have syntax highlighting compiled/enabled.
    │	└─ init.lua -- Don't touch this, it's used to load all the config.
    └─ plugins
	├─ 42 -- The init.lua file in this folder loads the 42Stdheader (Lausanne, by default. Change this if you are not from Lausanne!)
	├─ builtin -- This folder contains all the built-in plugins that make 42-Nvim what it is. Don't touch as it might get modified.
	├─ custom <<-- This is where you want to add your lua files to add custom plugins. An example file lives there.
	├─ extras <<-- This folder stores plugins that have either been used in the past and kept around OR plugins I have used during testing but kept disabled.
	├─ themes -- This folder contains all the current themes. You may add your own or delete those you don't use.
	└─ init.lua -- Do not touch this either, it's used to load all of the plugins.
```

---
## Keybinds?? Where?? Help????
First things first, `<Space>-s-h` will bring out a help menu containing the documentation for every installed plugin that provides it.

42-Nvim's dashboard (that is, if you launch `nvim` with no arguments) has a couple keybinds to keep your configuration and plug-ins up to date. `u` will update your plugins, `<Shift>-U` will fetch updates for 42-Nvim and merge them in your own fork, `p` will push your current configuration to GitHub and `<Shift-P>` will pull it instead. Relaunch after updating or pulling for it to take effect.

Besides that, here is a short list of useful shortcuts for navigating and using 42-Nvim:

<details><summary>Neo-tree shortcuts:</summary>

This section is the largest out of the bunch.
Keep in mind that most shortcuts only work when the cursor/focus is on Neo-Tree!

**Those keybinds are case-sensitive!**

| Keybind | Shortcut |
| :------ | :------- |
| `<CTRL>-h` | Toggle the Neo-Tree |
| `<CTRL>-d` | Toggle the Document Symbols pane |
| `<Space>` | Toggle folder (open/close) |
| `<Enter>` | Open file with widow picker |
| `<2-MouseL>` | Open file with widow picker |
| `<CTRL>-v` | Open selected file, splitting the selected buffer vertically |
| `<CTRL>-x` | Open selected file, splitting the selected buffer horizontally |
| `<CTRL>-k` | Add selected file/folder to Dashboard recents (can have up to 10) |
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

There are many more shortcuts, as shown by `which-key`, but here are a few of them.
`<CTRL>-W` is the leader combo for moving around. The next keybinds are case-insensitive.

| Keybind | Shortcut |
| :------ | :------- |
| `<CTRL>-W` | leader key to move around. |
| `<CTRL>-W-<Up>` | Move focus above. |
| `<CTRL>-W-<Left>` | Move focus to the left. |
| `<CTRL>-W-<Down>` | Move focus below. |
| `<CTRL>-W-<Right>` | Move focus to the right. |
| `<CTRL>-I` | Move focus above. |
| `<CTRL>-J` | Move focus to the left. |
| `<CTRL>-K` | Move focus below. |
| `<CTRL>-L` | Move focus to the right. |
| `<CTRL>-W-V` | Vertical split. |
| `<CTRL>-W-S` | Horizontal split. |
| `<CTRL>-W-Q` | Close active window. |
| `<CTRL>-Up` | Increase window height. |
| `<CTRL>-Down` | Decrease window height. |
| `<CTRL>-Right` | Increase window width. |
| `<CTRL>-Left` | Decrease window width. |

</details>

<details><summary>General shortcuts:</summary>

There are many more shortcuts, as shown by `which-key`, but here are a few of them.
`<Space>` is the leader key for many utilities. The next keybinds are case-insensitive.

| Keybind | Shortcut |
| :------ | :------- |
| `<Space>-<Space>` | Telescope into open buffers. |
| `<Space>-/` | Fuzzy search in current buffer. |
| `<Space>-?` | Telescope into recently opened files. |
| `<Space>-S-G` | Live Fuzzy Grep in current working directory. (my favourite!) |
| `<Space>-S-F` | Telescope into searching files. |
| `<Space>-S-H` | Telescope into searching help/documentation. |
| `<Space>-S-K` | Telescope into searching keymaps/shortcuts. |
| `<Space>-G-F` | Telescope search Git files. |
| `<Space>-L-G` | LazyGit interface. |
| `<Space>-L-D` | LazyDocker interface. |
| `<Space>-T` | Telescope into Themes. |

</details>

<details><summary>Coding shortcuts:</summary>

There are many more shortcuts, as shown by `which-key`, but here are a few of them.
`g` is the leader key for many coding shortcuts.

**Those keybinds are case-sensitive!**

| Keybind | Shortcut |
| :------ | :------- |
| `;-[` | Soft wrap mode (words wrap around) |
| `;-]` | Hard wrap mode (words do not wrap at all) |
| `;-\` | Switch line wrapping mode. |
| `g-c-c` | Toggle selection as line comment. |
| `g-b-c` | Toggle selection as block comment. |
| `g-c-A` | Insert comment at end of line. |
| `g-c-o` | Insert comment below. |
| `g-c-O` | Insert comment above. |
| `g-d` | Go to function definition. |
| `g-D` | Go to function declaration. |
| `g-I` | Go to function implementation. |
| `g-r` | Telescope every reference of a function. |
| `g-u` | Toggle selection to lowercase. |
| `g-U` | Toggle selection to uppercase. |
| `g-~` | Swap selection case. |
| `g-g` | Go to first line of document. |
| `g-i` | Go to last insertion. |
| `g-t` | Go to previous tab. |
| `g-T` | Go to next tab. |

There is a lot more to this so press `g` once and see what other keybinds you can use :)

</details>

While in normal mode, pressing leader keys and doing nothing afterwards will show you which possible keybinds can be achieved. This is done thanks to [which-key](https://github.com/folke/which-key.nvim).

Again, feel free to mess around and explore the config files. You may (will) learn a thing or two!

---
## Credits, contact and whatever
As I said, this would not have been possible without these two goats:
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [AstroNvim](https://github.com/AstroNvim/AstroNvim)

**In addition, I'd like to link back to *every* built-in plugin that made this "distribution" possible.** This should make it easier to navigate and see which plugins are installed, as well as making their documentation a little bit faster to access. And of course to credit them for their amazing work :)

<details><summary>Plugins used:</summary>

- [42 Header](https://github.com/42Paris/42header)
- [Norminette42](https://github.com/hardyrafael17/norminette42.nvim)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
- [fidget.nvim](https;//github.com/j-hui/fidget.nvim)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [image.nvim](https://github.com/3rd/image.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [lazydocker.nvim](https://github.com/crnvl96/lazydocker.nvim)
- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [lualine.nvim](https://github.com/folke/nvim-lualine/lualine.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [neodev.nvim](https://github.com/folke/neodev.nvim)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-lsp-notify](https://github.com/mrded/nvim-lsp-notify)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [nvim-window-picker](https://github.com/s1n7ax/nvim-window-picker)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [vim-obsession](https://github.com/tpope/vim-obsession)
- [vim-surround](https://github.com/tpope/vim-surround)
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
