#!/bin/bash
############################
# based on:
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh 
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="gitconfig tmux.conf vim vimrc zshrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

echo "Copying Battery script"
sudo ln -s ~/dotfiles/battery /usr/bin/battery

echo "Installing Vundle"
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "Install Vundle Bundles"
vim +BundleInstall +qall
echo "Installing tern_for_vim"

cd ~/.vim/bundle/tern_for_vim && `which npm` install 
echo "Installing YouCompleteMe"
cd ~/.vim/bundle/YouCompleteMe && ./install.sh

