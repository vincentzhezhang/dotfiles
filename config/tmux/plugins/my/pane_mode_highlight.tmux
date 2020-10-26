#! /usr/bin/env bash

#
# use different colours in pane border to represent different modes of the pane
#

set -exv

MY_TMUX_PLUGIN_LOG_PATH=${MY_TMUX_PLUGIN_LOG_PATH:-/tmp/my_tmux_plugins.log}

this_file="$(realpath --no-symlinks "${BASH_SOURCE[0]}")"

echo "Loading $this_file" >> "$MY_TMUX_PLUGIN_LOG_PATH"

here=$(dirname "$this_file")
utils_path="$here/utils"

echo "Sourcing utils: $utils_path" >> "$MY_TMUX_PLUGIN_LOG_PATH"

# shellcheck disable=SC1090
source "$utils_path"

default_copy_mode_border_style='fg=yellow'
default_normal_mode_border_style='fg=cyan'

copy_mode_border_style=$(get_tmux_option '@copy_mode_border_style' "$default_copy_mode_border_style")
normal_mode_border_style=$(get_tmux_option '@normal_mode_border_style' "$default_normal_mode_border_style")

tmux set-hook -g client-session-changed "run-shell '$this_file #{pane_in_mode} #{session_name}'"
tmux set-hook -g pane-mode-changed "run-shell '$this_file #{pane_in_mode} #{session_name}'"
tmux set-hook -g window-pane-changed "run-shell '$this_file #{pane_in_mode} #{session_name}'"

main()
{
  echo "Executing $this_file" >> "$MY_TMUX_PLUGIN_LOG_PATH"
  local pane_in_mode="$1"
  local session_name="$2"
  if [[ "$pane_in_mode" == '1' ]]; then
    set_tmux_option 'pane-active-border-style' "$copy_mode_border_style" "$session_name"
  else
    set_tmux_option 'pane-active-border-style' "$normal_mode_border_style" "$session_name"
  fi
}

main "$@"
