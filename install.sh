# install brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

brew install iterm2
brew install git
brew install tree # directory structure as a 'tree'
brew install bat # cooler cat
brew install ripgrep
brew install fd # simple, fast and user-friendly alternative to find
brew install golang
brew install python
python3 -m pip install --upgrade pip
brew install --cask visual-studio-code
brew install --cask docker
brew install zsh
brew install zsh-syntax-highlighting

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
	${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >>~/.zshrc

brew install tmux
# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neovim
brew install neovim --HEAD
sh -c 'curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
python3 -m pip install --user --upgrade pynvim

# nvm 0.39.1 and latest lts node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts
npm install --global yarn

# rvm
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
echo 409B6B1796C275462A1703113804BB82D39DC0E3:6: | gpg2 --import-ownertrust # mpapis@gmail.com
echo 7D2BAF1CF37B13E2069D6956105BD0E739499BDB:6: | gpg2 --import-ownertrust # piotr.kuczynski@gmail.com
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

# stow
brew install stow
stow gem
stow git
stow nvim
stow rvm
stow zsh
