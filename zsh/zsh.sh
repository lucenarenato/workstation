#verify zsh
type zsh >/dev/null 2>&1 || { echo >&2 "Install zsh before run this script "; exit 1; }

#verify curl
type curl >/dev/null 2>&1 || { echo >&2 "Install zsh before run this script "; exit 1; }

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#install zsh-syntax-highlighting.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#syslink 
ln -s -f $PWD/zshrc ~/.zshrc

#set zsh as default shell
clear
echo "To set zsh as default shell run sudo chsh -s $(which zsh)"
