#!/bin/bash

# 42-Nvim installer
# Hope you enjoy! :)

update() {
	echo "Updating 42-Nvim..."
	cd ~/.config/nvim
	git remote add upstream https://github.com/fclivaz42/42-nvim.git
	git fetch upstream
	git merge upstream -m "Script-update 42-Nvim to latest" && git push || echo "Could not automatically merge upstream into your branch. Please cd into your nvim directory and solve the conflict."
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
	gcc -v &>/dev/null || echo "WARNING: 'gcc' not installed!"
	git -v &>/dev/null || echo "WARNING: 'git' not installed! (how??)"
	make -v &>/dev/null || echo "WARNING: 'make' not installed!"
	unzip -v &>/dev/null || echo "WARNING: 'unzip' not installed!"
	lazygit -v &>/dev/null || echo "WARNING: 'lazygit' not installed!"
	lazydocker --version &>/dev/null || echo "WARNING: 'lazydocker' not installed!"
	rg -V &>/dev/null || echo "WARNING: 'ripgrep' not installed!"

	echo "End of the installer. If some dependencies are not installed, please do so, else 42-Nvim will have weird and undefined behavior."
	echo "Enjoy 42-Nvim! And if you got issues or an improvement, feel free to open an issue or a PR/MR on GitHub :)"
}

OLDPATH="$(pwd)"
case "$1" in
	"update")
		update
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
