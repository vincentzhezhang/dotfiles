#! /usr/bin/env bash

#
# gnome3 tweaks
#

if hash gsettings; then
  >&2 echo 'unbind some default values'
  gsettings set org.gnome.desktop.wm.keybindings minimize []

  >&2 echo 'setting up workspace short cuts'
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down  "['<Ctrl><Alt>j']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left  "['<Ctrl><Alt>h']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Ctrl><Alt>l']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up    "['<Ctrl><Alt>k']"

  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down  "['<Shift><Ctrl><Alt>j']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left  "['<Shift><Ctrl><Alt>h']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Ctrl><Alt>l']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up    "['<Shift><Ctrl><Alt>k']"

  >&2 echo 'setting better window switching behaviour'
  gsettings set org.gnome.desktop.wm.keybindings switch-applications []
  gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward []
  gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Super>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
  gsettings set org.gnome.shell.app-switcher current-workspace-only true
else
  >&2 echo 'gsettings not found!'
fi
