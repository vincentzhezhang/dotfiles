#! /usr/bin/env bash
#
# gnome3 tweaks
#
# Tweak the gnome-shell and its extensions to provide an unified workflow with
# same keyboard shortcuts across different DEs
#

set -e

unbind_all_shortcuts() {
  local schemadir
  schemadir=${1:-/usr/share/glib-2.0/schemas}
  namespace=${2:-''}
  gs_cmd="gsettings --schemadir $schemadir list-recursively $namespace"

  >&2 echo "Unbinding all shortcuts for schema '$schema_path' ..."
  while read -r line; do
    local unbind_value
    local key
    local value

    schema_ns=$(cut -d ' ' -f 1 <<< "$line")
    key=$(cut -d ' ' -f 2 <<< "$line")
    value=$(cut -d ' ' -f 3- <<< "$line")

    if [[ $schema_ns = *Legacy* ]]; then
      schema_path="/$(tr '.' '/' <<< "$schema_ns")/"
      schema_ns="$schema_ns:$schema_path"
    fi

    if [[ $value = [* ]]; then
      unbind_value='[]'
    else
      unbind_value="''"
    fi

    cmd="gsettings --schemadir $schemadir set $schema_ns $key $unbind_value"
    # >&2 echo "$cmd"
    eval "$cmd"
  done <<< "$(eval "$gs_cmd" | grep -E "['<]Control|Super|Alt|Shift|Primary" | sort)"
}

global_shortcut_tweaks() {
  unbind_all_shortcuts

  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down  "['<Ctrl><Alt>j']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left  "['<Ctrl><Alt>h']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Ctrl><Alt>l']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up    "['<Ctrl><Alt>k']"

  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down  "['<Ctrl><Alt><Shift>j']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left  "['<Ctrl><Alt><Shift>h']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Ctrl><Alt><Shift>l']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up    "['<Ctrl><Alt><Shift>k']"

  gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "['<Shift><Alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings cycle-group "['<Alt>Above_Tab']"

  gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']"
  gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
  gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
  gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Super>r']"

  gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Ctrl><Alt>t']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Ctrl><Alt>Delete']"

  # TODO rebind this to a better launcher
  gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>Space']"

  gsettings set org.gnome.mutter.keybindings switch-monitor "['<Super>p']"
}

gtile_tweaks() {
  if ! gsettings get org.gnome.shell enabled-extensions | grep -q 'gTile@vibou'; then
    >&2 echo 'gTile is not installed, skipping...'
  fi

  unbind_all_shortcuts ~/.local/share/gnome-shell/extensions/gTile@vibou/schemas/ org.gnome.shell.extensions.gtile

  gtile_set() (
    gsettings --schemadir ~/.local/share/gnome-shell/extensions/gTile@vibou/schemas/ set org.gnome.shell.extensions.gtile "$@"
  )

  # How does this work? The amazing grid tiling strategy!
  #
  # 4x4 grid
  #
  # +---+---+---+---+
  # |0:0|1:0|2:0|3:0|
  # +---+---+---+---+
  # |0:1|1:1|2:1|3:1|
  # +---+---+---+---+
  # |0:2|1:2|2:2|3:2|
  # +---+---+---+---+
  # |0:3|1:3|2:3|3:3|
  # +---+---+---+---+

  # left
  gtile_set preset-resize-1 "['<Super>h']"
  gtile_set resize1 '4x4 0:0 1:3,0:0 2:3,0:0 0:3'

  # right
  gtile_set preset-resize-2 "['<Super>l']"
  gtile_set resize2 '4x4 2:0 3:3,1:0 3:3,3:0 3:3'

  # top
  gtile_set preset-resize-3 "['<Super>k']"
  gtile_set resize3 '4x4 0:0 3:1,0:0 3:2,0:0 3:0'

  # bottom
  gtile_set preset-resize-4 "['<Super>j']"
  gtile_set resize4 '4x4 0:2 3:3,0:1 3:3,0:3 3:3'

  # top-left
  gtile_set preset-resize-5 "['<Super>1']"
  gtile_set resize5 '4x4 0:0 1:1,0:0 2:2,0:0 0:0'

  # top-right
  gtile_set preset-resize-6 "['<Super>2']"
  gtile_set resize6 '4x4 2:0 3:1,1:0 3:2,3:0 3:0'

  # bottom-left
  gtile_set preset-resize-7 "['<Super>3']"
  gtile_set resize7 '4x4 0:2 1:3,0:1 2:3,0:3 0:3'

  # bottom-right
  gtile_set preset-resize-8 "['<Super>4']"
  gtile_set resize8 '4x4 2:2 3:3,1:1 3:3,3:3 3:3'

  # middle
  gtile_set preset-resize-9 "['<Super>m']"
  gtile_set resize9 '6x6 1:1 4:4,0:0 5:5,2:2 3:3'

  gtile_set window-margin 0
  gtile_set insets-primary-bottom 0
  gtile_set insets-primary-left 0
  gtile_set insets-primary-right 0
  gtile_set insets-primary-top 0

  # some of the settings requires reload the extension
  gnome-extensions disable gTile@vibou && gnome-extensions enable gTile@vibou
}

other_tweaks() {
  gsettings set org.gnome.shell.app-switcher current-workspace-only true
  gsettings set org.gnome.shell.window-switcher current-workspace-only true
}

gnome_shell_tweaks() {
  if ! hash gnome-shell 2>/dev/null; then
    >&2 echo 'You are not using the gnome DE, existing!'
    return 1
  fi

 if ! hash gsettings; then
    >&2 echo 'gsettings not found!'
    return 1
  fi

  global_shortcut_tweaks
  gtile_tweaks
  other_tweaks
}

gnome_shell_tweaks
