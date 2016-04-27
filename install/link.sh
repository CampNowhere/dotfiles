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

if [ -e ~/.vim ]; then 
	echo "~/.vim already exists... Skipping."
else
	echo "Creating symlink for ~/.vim"
	ln -s $DOTFILES/config/nvim ~/.vim
fi

if [ -e ~/.vimrc ]; then 
	echo "~/.vimrc already exists... Skipping."
else
	echo "Creating symlink for ~/.vimrc"
	ln -s $DOTFILES/config/nvim/init.vim ~/.vimrc
fi
