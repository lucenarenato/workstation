#!/bin/sh
#
# installer_workstation.sh - Script to install my full DEBIAN 9 workstation experience
#
#Site        :https://renantmagalhaes.net
#Author      :Renan Toesqui Magalhães <renantmagalhaes@gmail.com>
#                                     <https://github.com/renantmagalhaes>
#
# ---------------------------------------------------------------
#
# This script  will make all the changes in the system and will download / install my most used packages.
#
#
# --------------------------------------------------------------
#
# Changelog
#
#   V0.1 2017-12-02 RTM:
#       - Initial release
#
#   V0.2 2017-12-03 RTM:
#       - added more packages from debian repo
#
#   V0.2.1 2017-12-03 RTM:
#       - Syntax adjustments
#       - Add github address in header
#       - Enable blowfish2 vim crypt method
#
#   V0.3 2017-12-11
#       - Added tmux plugin manager
#
#   V0.4 2017-12-29
#       - Rework Oh my fish! installation
#       - Auto install bobthefish
#
#   V0.5 2018-05-09
#       - Working on my own VIM config
#       - Removed Sublimetext editor -> Using Visual Code
#       - Removed Guake from default installed packages
#       - Change default browser -> Firefox to Google Chrome
#       - Changed default file manager -> Caja to Thunar
#       - Updated GTK theme version
#       - Added Visual Code Studio
#       - Added xfce plugins
#       - Added Draw.IO
#
#   V0.6 2018-05-28
#       - Added Gnome3 plugins
#       - Removed Draw.IO (use web version)
#       - Minor improvements
#
#   V0.7 2018-06-08
#       - Minor improvements
#       - Added VirtualBox
#
#   V0.7 2018-06-16
#       - Minor improvements
#       - Fix virtualbox install
#       - Fix var in oh-my-fish install
#
#   V0.7 2018-07-26
#       - Minor improvements
#       - Remove some gnome3 packages
#       - Add gnome-terminal package
#       - Add Gogh -Color Scheme for Gnome Terminal and Pantheon Terminal (https://github.com/Mayccoll/Gogh)
#       - Changed Thunar > Caja
#       - Changed OMF for Fisherman
#
#
#   V0.8 2018-08-31
#       - Change default vim install to spacevim
#
#   V0.9 2018-09-08
#       - Add numix-circle icons
#       - Add snap package manager
#       - Add mailspring email client(snap)
#       - Add Slack (snap)
#       - Add Telegram-desktop (snap)
#
#   V0.9.1 2018-09-08
#       - Minor spell check adjustment
#       - Change site to .net domain
#       - Change description
#
#   V1.0 2018-09-29
#       - All major "TODO" fix
#       - Change docky for plank
#       - Add themes for plank
#
#   V1.0.1 2018-10-01
#       - Plank autostart
#
#   V1.0.2 2019-02-28
#       - Vimix Theme
#       - New icons
#       - New fonts
#       - New Cursor
#
#
#   TODO
#   * Install telegram - site
#   * Fonts download
#   * Icons Fix
#   * set ignorecase in ~/.SpaceVim/vimrc
#   * Add zsh / oh-my-zsh as default shell
#   * Auto configure / install plugins for zsh
#   * Search new font for shell

#RTM

#Root check
if [ “$(id -u)” != “0” ]; then
echo “This script must be run as root” 2>&1
exit 1
fi

#User check
echo "#########################"
echo "#			#"
echo "#	User Config	#"
echo "#			#"
echo "#########################"

echo "Enter your default user name:"
read user

# source.list backup
cp /etc/apt/sources.list /etc/apt/sources.list.bkp

#Comment cdrom entry
sed -e '/deb cdrom:/ s/^#*/#/' -i /etc/apt/sources.list

#Add non-free packages
sed -e 's/main/main non-free/g' -i /etc/apt/sources.list


##Virtualbox part1
#Add Key
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
#Register source.list
echo "deb https://download.virtualbox.org/virtualbox/debian stretch contrib" > /etc/apt/sources.list.d/virtualbox.list

#Update / upgrade
apt-get update && apt-get -y upgrade


#Install the packages from debian repo
apt-get -y install zsh plank clementine deluge breeze-cursor-theme oxygen-cursor-theme oxygen-cursor-theme-extra dia vim vim-gtk vim-gui-common nmap vlc gimp blender gconf-editor fonts-powerline inkscape brasero gparted wireshark tmux curl net-tools iproute2 vpnc-scripts network-manager-vpnc vpnc network-manager-vpnc-gnome x2goclient xfce4-goodies xfce4-*plugin git gnome-icon-theme idle3 numix-gtk-theme numix-icon-theme firmware-linux firmware-linux-nonfree firmware-linux-free fonts-hack-ttf apt-transport-https htop meld dconf-cli openvpn network-manager-openvpn network-manager-openvpn-gnome snapd gnome-terminal gtk2-engines-murrine gtk2-engines-pixbuf python-pip

#Install the packages from snap repo

## slack
snap install slack --classic


#Update / upgrade
apt-get update && apt-get -y upgrade

##Virtualbox part2 (need apt-transport-https before install)
apt-get -y install virtualbox-5.2

####### Testing google-chrome for now ######
###Install Firefox Latest
wget -O ~/FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64"
sudo tar xjf ~/FirefoxSetup.tar.bz2 -C /opt/
sudo mv /usr/lib/firefox/firefox /usr/lib/firefox/firefox_backup
sudo ln -s /opt/firefox/firefox /usr/lib/firefox/firefox
rm -rf ~/FirefoxSetup.tar.bz2 



#Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
dpkg -i /tmp/google-chrome-stable_current_amd64.deb

#Install GTK theme Vimix- Repo dont exist anymore
git clone https://github.com/vinceliuice/vimix-gtk-themes.git /tmp/vimix
sh -c "/tmp/vimix/Install"




##Install Visual Code
wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/visual_code_amd64.deb
dpkg -i /tmp/visual_code_amd64.deb

#Install Fonts
git clone https://github.com/powerline/fonts.git /tmp/fonts/
bash /tmp/fonts/install.sh

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -O ~/.local/share/fonts/PowerlineSymbols.otf

mkdir -p ~/.config/fontconfig/conf.d/
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -O ~/.config/fontconfig/conf.d/10-powerline-symbols.conf

git clone https://github.com/gabrielelana/awesome-terminal-fonts.git /tmp/awesome-terminal-fonts
sh -c "/tmp/awesome-terminal-fonts/install.sh"

fc-cache -vf ~/.local/share/fonts/

#Add Gogh
##Elementary
runuser -l $user -c 'wget -O xt  http://git.io/v3D8R && chmod +x xt && ./xt && rm xt'
## Grubvbox dark
runuser -l $user -c 'wget -O xt https://git.io/v7eBS && chmod +x xt && ./xt && rm xt'

#Install fish
wget -nv https://download.opensuse.org/repositories/shells:fish:release:2/Debian_9.0/Release.key -O Release.key
apt-key add - < Release.key
apt-get update
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_9.0/ /' > /etc/apt/sources.list.d/fish.list
apt-get update
apt-get -y -f install
apt-get -y install fish
apt-get -y -f install

#Include Fish as user default shell
usermod -s /usr/bin/fish $user


#New VIM
runuser -l $user -c 'curl -sLf https://spacevim.org/install.sh' | bash

#Set Oh My Fish
#Credits <https://github.com/oh-my-fish/oh-my-fish>
runuser -l $user -c 'curl -L https://get.oh-my.fish > install'
runuser -l $user -c 'fish install --path=~/.local/share/omf --config=~/.config/omf --noninteractive'


#Set Fisherman(https://github.com/fisherman/fisherman)
runuser -l $user -c 'curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher'

#Add Fisherman packages
runuser -l $user -c 'fisher install edc/bass'
runuser -l $user -c 'fisher install laughedelic/pisces'
runuser -l $user -c 'fisher install z'
#runuser -l $user -c 'fisher install omf/theme-bobthefish'

#Add fish config
runuser -l $user -c 'touch ~/.config/fish/config.fish'

cat <<EOF >> /home/$user/.config/fish/config.fish
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_master_branch yes
#set -g theme_git_worktree_support yes
set -g theme_display_docker_machine yes
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_date_format "+%Y-%m-%d %H:%M"
set -g theme_title_display_process yes
#set -g theme_title_display_path yes
#set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path yes
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts no
set -g theme_show_exit_status yes
#set -g default_user your_normal_user
set -g fish_prompt_pwd_dir_length 1
set -g theme_newline_cursor no
set -g theme_color_scheme zenburn
EOF

#Set Tmux basic config
#CREDITS to Gregory <https://github.com/gpakosz>
runuser -l $user -c 'cd /home/$user'
runuser -l $user -c 'git clone https://github.com/gpakosz/.tmux.git'
runuser -l $user -c 'ln -s -f .tmux/.tmux.conf'
runuser -l $user -c 'cp .tmux/.tmux.conf.local .'

echo 'export TERM="xterm-256color"' >> /home/$user/.bashrc
echo 'alias tmux="tmux -2"' >> /home/$user/.bashrc

#Install plugin manager for tmux
#Credits  <https://github.com/tmux-plugins/tpm>
runuser -l $user -c 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'
cat <<EOF >> /home/$user/.tmux.conf
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @resurrect-capture-pane-contents 'on'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF

#Add bind keys to tmux
sed -i 's/bind -r C-l next-window/#bind -r C-l next-window/g' ~/.tmux.conf
sed -i 's/bind -r C-h previous-window/#bind -r C-h previous-window /g' ~/.tmux.conf
echo "bind -n M-Left  previous-window" >>  ~/.tmux.conf
echo "bind -n M-Right next-window" >>  ~/.tmux.conf

#Change Tmux separator icons
grep -rl "tmux_conf_theme_left" ~/.tmux.conf.local |xargs sed -i "s/tmux_conf_theme_left/#/g"
grep -rl "tmux_conf_theme_right" ~/.tmux.conf.local |xargs sed -i "s/tmux_conf_theme_right/#/g"
echo "tmux_conf_theme_left_separator_main=''" >> ~/.tmux.conf.local 
echo "tmux_conf_theme_left_separator_sub=''" >> ~/.tmux.conf.local
echo "tmux_conf_theme_right_separator_main=''" >> ~/.tmux.conf.local
echo "tmux_conf_theme_right_separator_sub=''" >> ~/.tmux.conf.local


#Install numix-circle-icons
runuser -l $user -c 'mkdir -p ~/.icons'
runuser -l $user -c 'git clone https://github.com/numixproject/numix-icon-theme-circle.git ~/.icons'
runuser -l $user -c 'gtk-update-icon-cache ~/.icons/Numix-Circle'
runuser -l $user -c 'gtk-update-icon-cache ~/.icons/Numix-Circle-Light'

#Install Vimix Icons
git clone https://github.com/vinceliuice/vimix-icon-theme.git /tmp/vimix-icons
sh -c "/tmp/vimix-icons/Installer.sh"

#Install Oranchelo Icons
mkdir -p /home/rtm/.local/share/icons/
git clone https://github.com/OrancheloTeam/oranchelo-icon-theme.git /tmp/oranchelo-icons
sh -c "/tmp/oranchelo-icons/oranchelo-installer.sh"

#Install plank themes
runuser -l $user -c 'mkdir -p ~/.local/share/plank/themes'
runuser -l $user -c 'git clone https://github.com/erikdubois/plankthemes.git ~/.local/share/plank/themes'

#Set plank autostart
runuser -l $user -c 'curl -o ~/.config/autostart/plank.desktop https://raw.githubusercontent.com/renantmagalhaes/workstation/static-files/plank-fix/plank.desktop'


#RTM
clear
echo "#################################"
echo "#                         #"
echo "#	www.renantmagalhaes.net	#"
echo "# Please reboot your pc   #"
echo "#                         #"
echo "#################################"
