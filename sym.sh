#!/usr/bin/env bash

update () {
  files=($(ls bin/dotfiles/sym))
  for f in "${files[@]}" 
  do
    if [ -f ~/."$f" -o -d ~/."$f" ]
    then
      # remove symlink from home directory
      rm -rf ~/."$f" 
    fi
    # symlink dotfiles from git repo
    ln -s -i bin/dotfiles/sym/"$f" ~/."$f"
  done
  ln -s -i bin/dotfiles/sym/.vim ~/.vim

  # update vim submodules
  cd bin/dotfiles/sym/vim 
  git submodule init
  git submodule update
}

create () {
  # make bin directory
  mkdir ~/bin 

  # symlink bin folder with dotfiles
  ln -s -i $(pwd)/bin/dotfiles ~/bin
  update
}

if [ -d ~/bin ]
then
  echo 'Updating dotfiles'
  update
else
  echo 'Creating dotfiles'
  create
fi
