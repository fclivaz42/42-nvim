#!/bin/bash

# 42-Nvim installer
# Hope you enjoy! :)

update() {
	echo "Updating 42-Nvim..."
	cd ~/.config/nvim
	if ! git remote -v  grep 'upstream'; then
		git remote add upstream https://github.com/fclivaz42/42-nvim.git
	fi
	git fetch upstream
	git rebase upstream/main && git push || echo "Could not automatically merge upstream into your branch. Please cd into your nvim directory and solve the conflict."
}

rebase() {
	cd ~/.config/nvim
	IFS=$'\n'
	TLINE=""
	HASH=""
	for line in $(git log --reverse --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)--- %an%C(reset)%C(auto)%d%C(reset)' --all); do
		if echo $line | grep '\--- fclivaz' &>/dev/null; then
			TLINE=$line
		else
			HASH="$(echo $TLINE | cut -f1 -d' ')"
			break
		fi
	done
	for line in $(git tag --list); do
		git tag -d $line
	done
	echo $HASH
	git reset --soft $HASH
	git restore --staged *
	git add lua/config/custom
	git add lua/plugins/custom
	git diff HEAD lua/config/42/init.lua > 42st.patch
	git diff HEAD lua/config/vim_settings.lua > vst.patch
	git stash --keep-index -m "bad stash with index"
	git stash -m "custom"
	git stash drop "$(git stash list | grep 'bad stash with index' | cut -f2 -d'{' | cut -f1 -d'}')"
	git reset --hard origin/main
	git remote add upstream https://github.com/fclivaz42/42-nvim
	git fetch upstream &>/dev/null
	git rebase --onto=upstream/main
	git stash apply
	git apply 42st.patch
	git apply vst.patch
	rm 42st.patch
	rm vst.patch
	git add .
	git stash drop
	git reflog expire --expire-unreachable=now --all
	git gc --prune=now --aggressive
	echo -e "\n---------------------------------------------------\n"
	git status
	echo -e "\n---------------------------------------------------\n"
	echo "WARN: Updated to V1.5 but did not commit nor push to GitHub."
	echo "WARN: Please verify that your configuration was properly imported and that no conflicts are present."
	echo "WARN: If it was not, you can still check with origin/main or what is currently on GitHub."
	echo "WARN: If you had any configuration that was *not* in the custom folders, now is a"
	echo "WARN: great time to properly move it there since upstream changes can overwrite yours."
	echo "WARN: Thank you for using 42-Nvim and enjoy the update!"
	echo "WARN: (Don't forget to commit and push --force once you are done.)"
	echo "WARN: (Updating on other devices should be as simple as 'git pull' and 'git rebase --onto=origin/main')"
}

clangd_flags() {
	UNAME="$(uname)"

	if [[ "$UNAME" == "Linux" ]]; then
		FILE="$HOME/.config/clangd/config.yaml"
		mkdir -p "$HOME/.config/clangd"
	elif [[ "$UNAME" == "Darwin" ]]; then
		FILE="$HOME/Library/Preferences/clangd/config.yaml"
		mkdir -p "$HOME/Library/Preferences/clangd"
	else
		echo "Unsupported OS."
		exit 1
	fi
	echo "Writing flags to $FILE"
	cat > "$FILE" << EOF
CompileFlags:
  Add: [-Wall, -Werror, -Wextra]
EOF
	echo "clangd flags set."
}

install() {
	until [[ "$ANSWER" =~ [yY][eE][sS] || "$ANSWER" =~ [yY] ]]; do
		read -p "Please enter your GitHub login: " GITNAME
		read -p "Is '$GITNAME' correct? [y/n] " ANSWER
		case "$ANSWER" in
			[yY][eE][sS] | [yY]) echo "Continuing."
			;;
			[nN][oO] | [nN]) echo "Restarting."
			;;
			*) echo "Unknown choice." && ANSWER="no"
			;;
		esac
	done

	ANSWER=""
	until [[ "$FORKED" =~ [yY][eE][sS] || "$FORKED" =~ [yY] ||"$FORKED" =~ [nN][oO] || "$FORKED" =~ [nN] ]]; do
		read -p "Have you renamed your fork? [y/n] " FORKED
		case "$FORKED" in
			[yY][eE][sS] | [yY])
			until [[ "$ANSWER" =~ [yY][eE][sS] || "$ANSWER" =~ [yY] ]]; do
				read -p "Please enter your fork name: " GITDIR
				read -p "Is '$GITDIR' correct? [y/n] " ANSWER
				case "$ANSWER" in
					[yY][eE][sS] | [yY]) echo "Cloning..."
					;;
					[nN][oO] | [nN]) echo "Restarting."
					;;
					*) echo "Unknown choice." && ANSWER="no"
					;;
				esac
			done
			;;
			[nN][oO] | [nN]) echo "Cloning..." && GITDIR="42-nvim"
			;;
			*) echo "Unknown choice." && ANSWER="no"
			;;
		esac
	done

	[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
	mkdir -p ~/.config/nvim
	git clone git@github.com:$GITNAME/$GITDIR.git ~/.config/nvim
	cd ~/.config/nvim
	git remote add upstream https://github.com/fclivaz42/42-nvim.git

	ANSWER=""
	until [[ "$STUD" =~ [yY][eE][sS] || "$STUD" =~ [yY] || "$STUD" =~ [nN][oO] || "$STUD" =~ [nN] ]]; do
	read -p "Are you a student of the 42 Network? [y/n] " STUD
		case "$STUD" in
			[yY][eE][sS] | [yY])
			until [[ "$ANSWER" =~ [yY][eE][sS] || "$ANSWER" =~ [yY] ]]; do
				read -p "Please enter your 42 login: " LOGIN
				read -p "Please enter your 42 email: " EMAIL
				read -p "Are '$LOGIN'  and '$EMAIL' correct? [y/n] " ANSWER
				case "$ANSWER" in
					[yY][eE][sS] | [yY])
					;;
					[nN][oO] | [nN]) echo "Restarting."
					;;
					*) echo "Unknown choice." && ANSWER="e"
					;;
				esac
			done
			sed -i "s/SET YOUR USER UP/$LOGIN/g" ./lua/config/42/init.lua
			sed -i "s/SET YOUR EMAIL UP/$EMAIL/g" ./lua/config/42/init.lua
			until [[ "$NORM" =~ [yY][eE][sS] || "$NORM" =~ [yY] || "$NORM" =~ [nN][oO] || "$NORM" =~ [nN] ]]; do
				read -p "Would you like to activate the built-in Norminette? [y/n] " NORM
				case "$NORM" in
					[yY][eE][sS] | [yY]) echo "Activating..."
					if ! norminette -v &>/dev/null; then
						if ! pip3 -V &>/dev/null; then
							echo "pip3 not found. Norminette cannot be installed!"
						else
							pip3 install norminette --break-system-packages
							sed -i 's/active = false/active = true/g' ./lua/config/42/init.lua
						fi
					else
						sed -i 's/active = false/active = true/g' ./lua/config/42/init.lua
					fi
					;;
					[nN][oO] | [nN]) echo "Skipping."
					;;
					*) echo "Unknown choice." && NORM="e"
					;;
				esac
			done
			;;
			[nN][oO] | [nN]) echo "Removing 42 plugins and configurations."
			sed -i '/42/d' ./lua/lazy_load.lua
			rm -rf ./lua/plugins/42
			sed -i '/42/d' ./lua/config/init.lua
			rm -rf ./lua/config/42
			;;
			*) echo "Unknown choice." && STUD="e"
			;;
		esac
	done

	until [[ "$UPDATER" =~ [yY][eE][sS] || "$UPDATER" =~ [yY] || "$UPDATER" =~ [nN][oO] || "$UPDATER" =~ [nN] ]]; do
		read -p "Would you like for 42-Nvim to notify you of its updates? [y/n] " UPDATER
		case "$UPDATER" in
			[yY][eE][sS] | [yY]) echo "Update notifications enabled."
			;;
			[nN][oO] | [nN]) echo "Update notifications disabled."
				sed -i 's/vim.g.receiveupdates = true/vim.g.receiveupdates = false/g' ./lua/config/vim_settings.lua
			;;
			*) echo "Unknown choice." && UPDATER="e"
			;;
		esac
	done

	until [[ "$CLANGD" =~ [yY][eE][sS] || "$CLANGD" =~ [yY] || "$CLANGD" =~ [nN][oO] || "$CLANGD" =~ [nN] ]]; do
		read -p "Would you like to install the -Wall -Werror -Wextra flags as defaults for clangd? (recommended) [y/n] " CLANGD
		case "$CLANGD" in
			[yY][eE][sS] | [yY]) echo "Setting flags..."
			clangd_flags
			;;
			[nN][oO] | [nN]) echo "Skipping."
			;;
			*) echo "Unknown choice." && CLANGD="e"
			;;
		esac
	done

	until [[ "$PUSH" =~ [yY][eE][sS] || "$PUSH" =~ [yY] || "$PUSH" =~ [nN][oO] || "$PUSH" =~ [nN] ]]; do
		read -p "Push this config to your GitHub? [y/n] " PUSH
		case "$PUSH" in
			[yY][eE][sS] | [yY]) echo "Pushing..."
			git add .
			git commit -m "Initial configuration."
			git push
			;;
			[nN][oO] | [nN]) echo "Skipping."
			;;
			*) echo "Unknown choice." && PUSH="e"
			;;
		esac
	done

	until [[ "$NF" =~ [yY][eE][sS] || "$NF" =~ [yY] || "$NF" =~ [nN][oO] || "$NF" =~ [nN] ]]; do
		read -p "Install a Nerd Font? (recommended for glyphs) [y/n] " NF
		case "$NF" in
			[yY][eE][sS] | [yY]) echo "Downloading..."
			mkdir -p ~/.local/share/fonts
			cd ~/.local/share/fonts
			LINK="https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/Meslo/M-DZ"
			curl -O $LINK/Regular/MesloLGMDZNerdFont-Regular.ttf
			curl -O $LINK/Regular/MesloLGMDZNerdFontMono-Regular.ttf
			curl -O $LINK/Regular/MesloLGMDZNerdFontPropo-Regular.ttf
			curl -O $LINK/Bold-Italic/MesloLGMDZNerdFont-BoldItalic.ttf
			curl -O $LINK/Bold-Italic/MesloLGMDZNerdFontMono-BoldItalic.ttf
			curl -O $LINK/Bold-Italic/MesloLGMDZNerdFontPropo-BoldItalic.ttf
			curl -O $LINK/Bold/MesloLGMDZNerdFont-Bold.ttf
			curl -O $LINK/Bold/MesloLGMDZNerdFontMono-Bold.ttf
			curl -O $LINK/Bold/MesloLGMDZNerdFontPropo-Bold.ttf
			curl -O $LINK/Italic/MesloLGMDZNerdFont-Italic.ttf
			curl -O $LINK/Italic/MesloLGMDZNerdFontMono-Italic.ttf
			curl -O $LINK/Italic/MesloLGMDZNerdFontPropo-Italic.ttf
			;;
			[nN][oO] | [nN]) echo "Skipping."
			;;
			*) echo "Unknown choice." && NF="e"
			;;
		esac
	done

	echo "All done!"

	echo "Checking dependencies..."
	gcc -v &>/dev/null || echo "WARNING: 'gcc' not installed! tree-sitter will not work!"
	git -v &>/dev/null || echo "WARNING: 'git' not installed! (how??) Litterally nothing is going to work!"
	make -v &>/dev/null || echo "WARNING: 'make' not installed! LSP's and tree-sitter will not work!"
	unzip -v &>/dev/null || echo "WARNING: 'unzip' not installed! Plugin installation will not work!"
	lazygit -v &>/dev/null || echo "WARNING: 'lazygit' not installed! Its plugin will not work"
	lazydocker --version &>/dev/null || echo "WARNING: 'lazydocker' not installed! Its plugin will not work."
	rg -V &>/dev/null || echo "WARNING: 'ripgrep' not installed! Telescope search will not properly work."
	tree-sitter -V &>/dev/null || echo "WARNING: 'tree-sitter-cli' not installed! Syntax highlighting/tree-sitter will not work."

	echo "End of the installer. If some dependencies are not installed, please do so, else 42-Nvim will have weird and undefined behavior."
	echo "Enjoy 42-Nvim! And if you got issues or an improvement, feel free to open an issue or a PR/MR on GitHub :)"
}

OLDPATH="$(pwd)"
case "$1" in
	"update")
		update
	;;
	"rebase")
		rebase
	;;
	"cflags")
		clangd_flags
	;;
	"install")
		install
	;;
	*) echo "Available uses: 'update', 'cflags', 'install'"
	;;
esac
cd $OLDPATH
[[ "$0" == *"installer.sh"* ]] && rm -- "$0"
