#install tmp (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


#Create syslinks 
ln -s -f $PWD/tmux.conf ~/.tmux.conf
ln -s -f $PWD/tmux.conf.local ~/.tmux.conf.local
