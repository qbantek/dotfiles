# install brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# disable analytics
brew analytics off

# install iTerm2
brew install iterm2

# install git
brew install git

# install nvm 0.39.1 and latest lts node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts

# have brew manage zsh installation
brew install zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
	${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >>~/.zshrc

# zsh-syntax-highlighting plugin
brew install zsh-syntax-highlighting

# bat
brew install bat

# neovim
brew install neovim --HEAD

sh -c 'curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# vscode
brew install --cask visual-studio-code

# docker
brew install --cask docker

# stow
brew install stow
stow git
stow nvim
stow zsh
