#!/usr/local/bin/bash

echo $BASH_VERSION

DOTFILES=$HOME/.dotfiles

echo -e "\nCreating symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
	target="$HOME/.$( basename $file '.symlink' )"
	if [ -e $target ]; then
		echo "~${target#$HOME} already exists... Skipping."
	else
		echo "Creating symlink for $file"
		ln -s $file $target
	fi
done

echo -e "\n\nInstalling to ~/.config"
echo "=============================="
if [ ! -d $HOME/.config ]; then
	echo "Creating ~/.config"
	mkdir -p $HOME/.config
fi

for config in $DOTFILES/config/*; do
	target=$HOME/.config/$( basename $config )
	if [ -e target ]; then
		echo "~${target#$HOME} already exists... Skipping."
	else
		echo "Creating symlink for $config"
		ln -s $config $target
	fi
done

# Create vim symlinks

echo -e "\n\nCreating vim symlinks"
echo "=============================="

vimfiles=($DOTFILES/config/nvim $DOTFILES/config/nvim/init.vim)

for file in ${vimfiles[@]}; do
	if [ -e ${file} ]; then 
		echo "${file} already exists... Skipping."
	else
		echo "Creating symlink for $file"
		ln -s $vimfiles[$file] $file
	fi
done

