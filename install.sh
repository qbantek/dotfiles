#!/bin/bash
{ # This ensures the entire script is downloaded.

set -eo pipefail

basedir="$HOME/projects/dotfiles"
vundledir="$HOME/.vim/bundle/Vundle.vim"
repourl="git@github.com:qbantek/dotfiles.git"
vundleurl="git@github.com:VundleVim/Vundle.vim.git"

function symlink() {
  src="$1"
  dest="$2"

  if [ -e "$dest" ]; then
    if [ -L "$dest" ]; then
      if [ ! -e "$dest" ]; then
        echo "Removing broken symlink at $dest"
        rm "$dest"
      else
        # Already symlinked -- I'll assume correctly.
        return 0
      fi
    else
      # Rename files with a ".old" extension.
      echo "$dest already exists, renaming to $dest.old"
      backup="$dest.old"
      if [ -e "$backup" ]; then
        echo "Error: "$backup" already exists. Please delete or rename it."
        exit 1
      fi
      mv -v "$dest" "$backup"
    fi
  fi
  ln -sf "$src" "$dest"
}


if [ -d "$basedir/.git" ]; then
  echo "Updating dotfiles using existing git..."
  cd "$basedir"
  git pull --quiet --rebase origin master || exit 1
else
  echo "Checking out dotfiles using git..."
  rm -rf "$basedir"
  git clone --quiet --depth=1 "$repourl" "$basedir"
fi

if [ -d "$vundledir/.git" ]; then
  echo "Updating Vundle using existing git..."
  cd "$vundledir"
  git pull --quiet --rebase origin master || exit 1
else
  echo "Checking out Vundle using git..."
  rm -rf "$vundledir"
  git clone --quiet --depth=1 "$vundleurl" "$vundledir"
fi

cd "$basedir"

echo "Creating symlinks..."
echo " --bash"
# symlink "$basedir/bash_profile" "$HOME/.bash_profile"
# symlink "$basedir/bashrc" "$HOME/.bashrc"
# symlink "$basedir/bash_aliases" "$HOME/.bash_aliases"

echo " --rails"
symlink "$basedir/railsrc" "$HOME/.railsrc"

echo " --vim"
symlink "$basedir/.vim/vimrc" "$HOME/.vimrc"
symlink "$basedir/.vim/vimrc.bundles" "$HOME/.vimrc.bundles"

echo " --git"
symlink "$basedir/gitattribute" "$HOME/.gitattributes"
symlink "$basedir/gitignore" "$HOME/.gitignore"

echo " --tmux"
symlink "$basedir/tmux.conf" "$HOME/.tmux.conf"

echo "Done."

} # This ensures the entire script is downloaded.
