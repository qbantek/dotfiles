#!/bin/sh

{ # This ensures the entire script is downloaded.

# Install Command-line tools as dependency for Homebrew
xcode-select --install # Sets the path for the active developer directory to /Library/Developer/CommandLineTools

# brew & tools
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew analytics off
brew update
brew install mas #  command-line interface for Mac App Store

# Xcode
mas search xcode | head -5 # search for Xcode showing only the first 5 results
mas install 497799835 # appid for Xcode
sudo xcode-select --reset  # Sets the path for the active developer directory to /Applications/Xcode.app/Contents/Developer
sudo softwareupdate --install --all --agree-to-license # Update all Apple software and auto agree to any licenses 
sudo xcodebuild -license accept # agree to xcode license

# show hidden files
defaults write com.apple.Finder "AppleShowAllFiles" -bool true
# do not offer new disks for Time Machine Backup
defaults write com.apple.TimeMachine "DoNotOfferNewDisksForBackup" -bool true
# auto-hide the dock
defaults write com.apple.dock "autohide" -bool true
# size of icons in the dock
defaults write com.apple.dock "tilesize" -int "40"

# git
brew install git
# see https://www.git-tower.com/blog/make-git-rebase-safe-on-osx
git config --global core.trustctime false
git config --global core.editor vim
git config --global core.excludesfile ~/.gitignore_global
git config --global user.name "Erich N Quintero"
git config --global user.email "qbantek@gmail.com"

# GitHub
brew install gh
gh config set editor vim
gh config set git_protocol ssh --host github.com

# setup git ssh to GitHub
ssh-keygen -t ed25519 -C qbantek@gmail.com
ssh-add ~/.ssh/id_ed25519
gh auth login

# setup gpg signed commits
echo "Adding a GPG key:"
echo "Supported GPG key algorithms: RSA, ElGamal, DSA, ECDH, ECDSA, EdDSA."
echo "Your key must be at least 4096 bits."
gpg --full-generate-key
gpg_key_id=`gpg --list-signatures --with-colons | grep 'sig' | grep 'qbantek@gmail.com' | head -n 1 | cut -d':' -f5F`
ascii_key=`gpg --armor --export "$gpg_key_id"`
git config --global user.signingkey $gpg_key_id
git config --global commit.gpgsign true
gh gpg-key add $ascii_key

# clone dotfiles from GitHub
basedir="$HOME/dotfiles"
rm -rf "$basedir"
git clone git@github.com:qbantek/dotfiles.git "$basedir"
cd "$basedir"
git checkout mbpro # mac branch

brew install gnupg  # make sure we have gpg available
brew install iterm2 # preferred terminal
brew install tree # directory structure as a 'tree'
brew install bat  # cooler cat
brew install ripgrep
brew install fd   # simple, fast and user-friendly alternative to find
brew install fzf  # fuzzy finder
$(brew --prefix)/opt/fzf/install
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_CUSTOM/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/Aloxaf/fzf-tab \
  "$ZSH_CUSTOM/plugins/fzf-tab"

# tmux
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# nvm 0.39.1 and latest lts node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sh
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts
npm install --global npm@latest
npm install --global yarn
PATH="$PATH:`yarn global bin`"

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

# tools

brew install --cask visual-studio-code
brew install --cask docker
brew install --cask google-chrome
brew install --cask postman

# stow
brew install stow

rm -rf ~/.zshrc
rm -rf ~/.config/nvim
rm -rf ~/.rvm/gemsets/global.gems

stow gem                 
stow git
stow nvim
stow rvm
stow zsh

# install nvim plugins
nvim --headless +PlugInstall +qall

} # This ensures the entire script is downloaded.
