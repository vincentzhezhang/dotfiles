#! /bin/bash

# bash related
rsync -avz /home/vincent/.bashrc .bashrc
rsync -avz /home/vincent/.bash_ps1 .bash_ps1
rsync -avz /home/vincent/.bash_aliases .bash_aliases
rsync -avz /home/vincent/.bash_constants .bash_constants
rsync -avz /home/vincent/.bash_functions .bash_functions
rsync -avz /home/vincent/.bash_profile .bash_profile

# terminator configuration
rsync -avz /home/vincent/.config/terminator/config .config/terminator/config

# vim
rsync -avz /home/vincent/.vimrc .vimrc
rsync -avz /home/vincent/.vim/ .vim/
rsync -avz /home/vincent/.vim-fuf-data/ .vim-fuf-data/

# geit
rsync -avz /home/vincent/.local/share/gedit/ .local/share/gedit/

# misc
rsync -avz /home/vincent/.dircolors .dircolors
