#!/bin/bash

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
