#! /usr/bin/env bash
echo 'Installing generic configuration...'
stow -v2 -t ~ bash
stow -v2 -t ~ git
stow -v2 -t ~ tmux
stow -v2 -t ~ vim

# make link for neovim
ln -s ~/.vimrc ~/.vim/init.vim

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo 'Installing Linux specific configuration...'
  mkdir -pv ~/.config
  stow -v2 -t ~/.config linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo 'Installing OSX specific configuration...'
else
  echo 'You are using some weird system man'
fi

cat << EOF

 ██████╗  ██████╗ ███╗   ██╗███████╗
 ██╔══██╗██╔═══██╗████╗  ██║██╔════╝
 ██║  ██║██║   ██║██╔██╗ ██║█████╗
 ██║  ██║██║   ██║██║╚██╗██║██╔══╝
 ██████╔╝╚██████╔╝██║ ╚████║███████╗
 ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝

EOF
