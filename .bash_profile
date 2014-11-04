if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
# Initialization for FDK command line tools.Mon Aug 11 16:45:11 2014
FDK_EXE="/home/vincent/bin/FDK/Tools/linux"
PATH=${PATH}:"/home/vincent/bin/FDK/Tools/linux"
export PATH
export FDK_EXE
