# Install general packages
# sudo apt update -y
# sudo apt install -y curl git python-dev python-pip python3-dev python3-pip

# Install oh-my-zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k theme
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set theme in .zshrc
# echo 'source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

echo "-----------------------------------------------------------------"
echo "Download and install Meslo fonts!"
echo "https://github.com/romkatv/powerlevel10k#manual-font-installation"
echo "-----------------------------------------------------------------"

# Install docker
# sudo apt install -y apt-transport-https ca-certificates software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# sudo apt update -y
# apt-cache policy docker-ce
# sudo apt install docker-ce

# Install neovim
# sudo add-apt-repository ppa:neovim-ppa/unstable -y
# sudo apt update -y
# sudo apt install -y neovim

# Install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

# cleanup
sudo apt autoremove -y
