#!/bin/sh
{ # This ensures the entire script is downloaded.
set -eo pipefail

# brew & tools
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off
brew install iterm2
brew install tree # directory structure as a 'tree'
brew install bat  # cooler cat
brew install ripgrep
brew install fd   # simple, fast and user-friendly alternative to find
brew install --cask visual-studio-code
brew install --cask docker

# git
brew install git

# username
gitname=`git config --global user.name`
if [ -z "$gitname" ]; then
	gitname="Erich N Quintero"
fi
read -p "Enter git committer name (return to use '$gitname'): " -e newgitname
if [ -z "$newgitname" ]; then
	newgitname=$gitname
fi
`git config --global user.name "$newgitname"`

# email
gitemail=`git config --global user.email`
if [ -z "$gitemail" ]; then
	gitemail="qbantek@gmail.com"
fi
read -p "Enter git committer email (return to use '$gitemail'): " -e newgitemail
if [ -z "$newgitemail" ]; then
	newgitemail=$gitemail
fi
`git config --global user.email "$newgitemail"`


# GitHub
brew install gh
ssh-keygen -t ed25519 -C $newgitemail
ssh-add ~/.ssh/id_ed25519
gh config set editor vim
gh config set git_protocol ssh --host github.com
gh auth login
gh ssh-key add ~/.ssh/id_ed25519.pub
ssh -T git@github.com

echo "Adding a GPG key:"
echo "Supported GPG key algorithms: RSA, ElGamal, DSA, ECDH, ECDSA, EdDSA."
echo "Your key must be at least 4096 bits."
gpg --full-generate-key
gpg_key_id=`gpg --list-signatures --with-colons | grep 'sig' | grep 'qbantek@gmail.com' | head -n 1 | cut -d':' -f5F`
ascii_key=`gpg --armor --export "$gpg_key_id"`
git config --global user.signingkey $gpg_key_id
git config --global commit.gpgsign true
gh gpg-key add $ascii_key

# clone or update dotfiles from GitHub
basedir="$HOME/dotfiles"
repourl="git@github.com:qbantek/dotfiles.git"
if [ -d "$basedir/.git" ]; then
  echo "Updating dotfiles using existing git..."
  cd "$basedir"
  git pull --quiet --rebase origin master || exit 1
else
  echo "Checking out dotfiles using git..."
  rm -rf "$basedir"
  git clone --quiet --depth=1 "$repourl" "$basedir"
fi

# zsh
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_CUSTOM/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# tmux
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# nvm 0.39.1 and latest lts node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts
npm install --global npm@latest
npm install --global yarn

# go
brew install golang

# python
brew install python
python3 -m pip install --upgrade pip

# rvm
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
echo 409B6B1796C275462A1703113804BB82D39DC0E3:6: | gpg2 --import-ownertrust # mpapis@gmail.com
echo 7D2BAF1CF37B13E2069D6956105BD0E739499BDB:6: | gpg2 --import-ownertrust # piotr.kuczynski@gmail.com
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

# neovim
brew install neovim --HEAD
sh -c 'curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  python3 -m pip install --user --upgrade pynvim

# stow
brew install stow
stow gem
stow git
stow nvim
stow rvm
stow zsh

# install nvim plugins
nvim --headless +PlugInstall +qall

} # This ensures the entire script is downloaded.
