# fclivaz' nvim config

you are free to use it, just make sure to tune it beforehand (eg. change your 42header or delete the lua files of plugins you don't want to use.)

for 42 students, what you need to edit is in `lua/config/vim_settings.lua`. you might also want to enable the built-in norminette by setting `active = true` in `lua/plugins/42norminette.lua`.

**if you dont have `clangd` installed, edit `lua/config/lsp.lua` and comment or delete line 72 (which should be `require('lspconfig').clangd.setup{}`).**

in order to install:

```shell
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/fclivaz42/nvim-config ~/.config/nvim
```
or 
```shell
git clone git@github.com:fclivaz42/nvim-config.git ~/.config/nvim
```
if you are me :)

enjoy!
